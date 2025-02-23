#include "DeviceManager.h"

DeviceManager::DeviceManager(QObject *parent)
    : QObject(parent), m_manager(new QNetworkAccessManager(this)) {
  connect(m_manager, &QNetworkAccessManager::finished, this,
          &DeviceManager::handleNetworkReply);
}

void DeviceManager::fetchDevices() {
  QNetworkRequest request(QUrl("https://api.dev.aircast.one/auth/devices"));
  request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
  m_manager->get(request);
}

void DeviceManager::handleNetworkReply(QNetworkReply *reply) {
  if (reply->error() == QNetworkReply::NoError) {
    QByteArray data = reply->readAll();
    QJsonDocument doc = QJsonDocument::fromJson(data);
    if (doc.isArray()) {
      m_devices = doc.array().toVariantList();
      emit devicesChanged();
    }
  }
  reply->deleteLater();
}