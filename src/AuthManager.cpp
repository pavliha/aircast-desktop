// AuthManager.cpp
#include "AuthManager.h"

#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QSettings>
#include <QUrlQuery>

AuthManager::AuthManager(QObject *parent)
    : QObject(parent),
      m_networkManager(new QNetworkAccessManager(this)),
      m_pollTimer(new QTimer(this)),
      m_isAuthenticated(false) {
  // Configure polling timer
  m_pollTimer->setInterval(2000);  // Poll every 2 seconds
  connect(m_pollTimer, &QTimer::timeout, this,
          &AuthManager::onPollTimerTimeout);

  // Check if we have a stored token
  QSettings settings;
  m_userToken = settings.value("auth/token").toString();

  if (!m_userToken.isEmpty()) {
    // We have a token, validate it by getting user data
    m_isAuthenticated = true;
    emit authStatusChanged();
    getUserProfile();
  }
}

bool AuthManager::isAuthenticated() const { return m_isAuthenticated; }

QString AuthManager::userToken() const { return m_userToken; }

QVariantMap AuthManager::userData() const { return m_userData; }

void AuthManager::startGoogleSignIn() {
  // First, create an authentication session
  createAuthSession();
}

void AuthManager::signOut() {
  // Call the sign-out API
  QNetworkRequest request(QUrl(API_BASE_URL + "/v1/auth/sessions"));
  request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

  if (!m_userToken.isEmpty()) {
    request.setRawHeader("Authorization", "Bearer " + m_userToken.toUtf8());
  }

  QNetworkReply *reply = m_networkManager->deleteResource(request);

  connect(reply, &QNetworkReply::finished, this, [this, reply]() {
    reply->deleteLater();

    // Clear local auth data
    m_userToken.clear();
    m_userData.clear();
    m_isAuthenticated = false;

    // Clear stored token
    QSettings settings;
    settings.remove("auth/token");

    emit userTokenChanged();
    emit userDataChanged();
    emit authStatusChanged();
  });
}

void AuthManager::createAuthSession() {
  QNetworkRequest request(QUrl(API_BASE_URL + "/v1/auth/sessions"));
  request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

  // Create the request body (empty JSON object is fine for this endpoint)
  QJsonObject requestBody;
  requestBody["platform"] = "desktop";  // You can add device info if needed

  QJsonDocument doc(requestBody);
  QByteArray data = doc.toJson();

  QNetworkReply *reply = m_networkManager->post(request, data);

  connect(reply, &QNetworkReply::finished, this,
          [this, reply]() { onSessionTokenReceived(reply); });
}

void AuthManager::onSessionTokenReceived(QNetworkReply *reply) {
  reply->deleteLater();

  if (reply->error() != QNetworkReply::NoError) {
    emit signInFailed("Failed to create authentication session: " +
                      reply->errorString());
    return;
  }

  // Parse the response to get the token
  QByteArray responseData = reply->readAll();
  QJsonDocument doc = QJsonDocument::fromJson(responseData);
  QJsonObject obj = doc.object();

  if (obj.contains("token")) {
    m_sessionToken = obj["token"].toString();

    // Now open the browser with the Google Auth URL
    QUrl authUrl(API_BASE_URL + "/v1/auth/google");
    QUrlQuery query;
    query.addQueryItem("token", m_sessionToken);
    authUrl.setQuery(query);

    // Open the URL in the default browser
    QDesktopServices::openUrl(authUrl);

    // Start polling for authentication status
    startPolling(m_sessionToken);
  } else {
    emit signInFailed("Invalid response from server");
  }
}

void AuthManager::startPolling(const QString &token) {
  m_sessionToken = token;
  m_pollTimer->start();
}

void AuthManager::onPollTimerTimeout() {
  // Poll the server to check if authentication is complete
  QNetworkRequest request(
      QUrl(API_BASE_URL + "/v1/auth/sessions/poll/" + m_sessionToken));

  QNetworkReply *reply = m_networkManager->get(request);

  connect(reply, &QNetworkReply::finished, this, [this, reply]() {
    reply->deleteLater();

    if (reply->error() != QNetworkReply::NoError) {
      int statusCode =
          reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();

      // 202 means authentication is still pending
      if (statusCode == 202) {
        // Continue polling
        return;
      }

      // For any other error, stop polling and notify failure
      m_pollTimer->stop();
      emit signInFailed("Authentication failed: " + reply->errorString());
      return;
    }

    // Parse the response
    QByteArray responseData = reply->readAll();
    QJsonDocument doc = QJsonDocument::fromJson(responseData);
    QJsonObject obj = doc.object();

    // Check if authentication is complete
    if (obj.contains("session_token")) {
      // Stop polling
      m_pollTimer->stop();

      // Save the user token
      m_userToken = obj["session_token"].toString();

      // Store token for persistence
      QSettings settings;
      settings.setValue("auth/token", m_userToken);

      m_isAuthenticated = true;

      // Get user profile data
      getUserProfile();

      emit userTokenChanged();
      emit authStatusChanged();
      emit signInSuccessful();
    }
  });
}

void AuthManager::getUserProfile() {
  if (m_userToken.isEmpty()) {
    return;
  }

  QNetworkRequest request(QUrl(API_BASE_URL + "/v1/auth/me"));
  request.setRawHeader("Authorization", "Bearer " + m_userToken.toUtf8());

  QNetworkReply *reply = m_networkManager->get(request);

  connect(reply, &QNetworkReply::finished, this, [this, reply]() {
    reply->deleteLater();

    if (reply->error() != QNetworkReply::NoError) {
      // If we get an authentication error, clear the token
      if (reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt() ==
          401) {
        m_userToken.clear();
        m_isAuthenticated = false;

        QSettings settings;
        settings.remove("auth/token");

        emit userTokenChanged();
        emit authStatusChanged();
      }
      return;
    }

    // Parse user data
    QByteArray responseData = reply->readAll();
    QJsonDocument doc = QJsonDocument::fromJson(responseData);
    QJsonObject obj = doc.object();

    // Convert JSON to QVariantMap
    m_userData = obj.toVariantMap();

    emit userDataChanged();
  });
}