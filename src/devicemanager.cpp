// DeviceManager.cpp
#include "DeviceManager.h"

#include <QJsonArray>
#include <QJsonObject>

DeviceManager::DeviceManager(QObject *parent)
    : QObject(parent), m_networkManager(new QNetworkAccessManager(this)) {
  connect(m_networkManager, &QNetworkAccessManager::finished, this,
          &DeviceManager::handleNetworkReply);
}

void DeviceManager::setAuthManager(AuthManager *authManager) {
  if (m_authManager == authManager) return;

  if (m_authManager) {
    disconnect(m_authManager, &AuthManager::authStatusChanged, this,
               &DeviceManager::onAuthStatusChanged);
  }

  m_authManager = authManager;

  if (m_authManager) {
    connect(m_authManager, &AuthManager::authStatusChanged, this,
            &DeviceManager::onAuthStatusChanged);

    // No need to access private API_BASE_URL from AuthManager
    // We already have m_apiBaseUrl defined in the header
  }
}

void DeviceManager::onAuthStatusChanged() {
  if (m_authManager && m_authManager->isAuthenticated()) {
    fetchDevices();
  } else {
    // Clear devices when logged out
    m_devices.clear();
    emit devicesChanged();
  }
}

void DeviceManager::fetchDevices() {
  if (!m_authManager || !m_authManager->isAuthenticated()) {
    // Not authenticated, can't fetch devices
    return;
  }

  QNetworkRequest request(QUrl(m_apiBaseUrl + "/v1/devices"));
  request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

  // Add the authorization header with the token from AuthManager
  request.setRawHeader("Authorization",
                       "Bearer " + m_authManager->userToken().toUtf8());

  m_networkManager->get(request);
}

void DeviceManager::handleNetworkReply(QNetworkReply *reply) {
  reply->deleteLater();

  if (reply->error() != QNetworkReply::NoError) {
    emit error("Network error: " + reply->errorString());
    return;
  }

  QByteArray responseData = reply->readAll();
  QJsonDocument jsonDoc = QJsonDocument::fromJson(responseData);

  if (jsonDoc.isArray()) {
    m_devices = jsonDoc.array().toVariantList();
    emit devicesChanged();
  } else {
    emit error("Invalid response format");
  }
}