#include "DeviceManager.h"

#include <QDebug>
#include <QJsonArray>
#include <QJsonObject>

DeviceManager::DeviceManager(QObject *parent) : QObject(parent) {
  m_networkManager = new QNetworkAccessManager(this);

  // Initialize API URL from environment variable with fallback
  m_apiBaseUrl =
      qEnvironmentVariable("AIRCAST_API_URL", "http://localhost:3333");

  qDebug() << "Device Manager using API URL:" << m_apiBaseUrl;
}

void DeviceManager::setApiBaseUrl(const QString &url) {
  if (m_apiBaseUrl != url) {
    m_apiBaseUrl = url;
    emit apiBaseUrlChanged();

    // Refresh devices when URL changes
    if (m_authManager && m_authManager->isAuthenticated()) {
      fetchDevices();
    }
  }
}

void DeviceManager::fetchDevices() {
  if (!m_authManager || !m_authManager->isAuthenticated()) {
    emit error("Not authenticated");
    return;
  }

  QNetworkRequest request;
  request.setUrl(QUrl(m_apiBaseUrl + "/v1/devices"));
  request.setRawHeader("Authorization",
                       "Bearer " + m_authManager->token().toUtf8());

  QNetworkReply *reply = m_networkManager->get(request);
  connect(reply, &QNetworkReply::finished, this,
          [this, reply]() { handleNetworkReply(reply); });
}

void DeviceManager::setAuthManager(AuthManager *authManager) {
  if (m_authManager != authManager) {
    // Disconnect previous connections
    if (m_authManager) {
      disconnect(m_authManager, &AuthManager::authStatusChanged, this,
                 &DeviceManager::onAuthStatusChanged);
    }

    m_authManager = authManager;

    if (m_authManager) {
      // Connect to auth status changes
      connect(m_authManager, &AuthManager::authStatusChanged, this,
              &DeviceManager::onAuthStatusChanged);

      // Just set the API URL once here
      setApiBaseUrl(m_authManager->apiBaseUrl());
    }
  }
}

void DeviceManager::handleNetworkReply(QNetworkReply *reply) {
  reply->deleteLater();

  if (reply->error() != QNetworkReply::NoError) {
    emit error(reply->errorString());
    return;
  }

  QByteArray data = reply->readAll();
  QJsonDocument doc = QJsonDocument::fromJson(data);

  if (doc.isArray()) {
    m_devices.clear();
    QJsonArray array = doc.array();

    for (const QJsonValue &value : array) {
      if (value.isObject()) {
        m_devices.append(value.toObject().toVariantMap());
      }
    }

    emit devicesChanged();
  } else {
    emit error("Invalid response format");
  }
}

void DeviceManager::onAuthStatusChanged() {
  if (m_authManager && m_authManager->isAuthenticated()) {
    fetchDevices();
  } else {
    m_devices.clear();
    emit devicesChanged();
  }
}