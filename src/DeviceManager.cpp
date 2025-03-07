// DeviceManager.cpp
#include "DeviceManager.h"

#include <QDebug>
#include <QJsonArray>
#include <QJsonObject>

DeviceManager::DeviceManager(QObject *parent, AuthManager *authManager)
    : QObject(parent), m_authManager(authManager) {
  m_networkManager = new QNetworkAccessManager(this);

  // Use the same API URL as AuthManager
  m_apiBaseUrl =
      qEnvironmentVariable("AIRCAST_API_URL", "http://localhost:3333");

  qDebug() << "Device Manager using API URL:" << m_apiBaseUrl;

  // Connect to auth status changes
  if (m_authManager) {
    connect(m_authManager, &AuthManager::authStatusChanged, this,
            &DeviceManager::onAuthStatusChanged);

    // Initial fetch if already authenticated
    if (m_authManager->isAuthenticated()) {
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

QVariantMap DeviceManager::getDeviceById(const QString &deviceId) const {
  for (const QVariant &device : m_devices) {
    QVariantMap deviceMap = device.toMap();
    if (deviceMap["id"].toString() == deviceId) {
      return deviceMap;
    }
  }
  return QVariantMap();  // Return empty map if not found
}