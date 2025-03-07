// DeviceManager.h
#ifndef DEVICEMANAGER_H
#define DEVICEMANAGER_H

#include <QJsonDocument>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QObject>
#include <QVariantList>

#include "AuthManager.h"

class DeviceManager : public QObject {
  Q_OBJECT
  Q_PROPERTY(QVariantList devices READ devices NOTIFY devicesChanged)

 public:
  explicit DeviceManager(QObject *parent = nullptr,
                         AuthManager *authManager = nullptr);

  QVariantList devices() const { return m_devices; }

 public slots:
  void fetchDevices();

 signals:
  void devicesChanged();
  void error(const QString &message);

 private slots:
  void handleNetworkReply(QNetworkReply *reply);
  void onAuthStatusChanged();

 private:
  QNetworkAccessManager *m_networkManager;
  QVariantList m_devices;
  AuthManager *m_authManager;
  QString m_apiBaseUrl;
};

#endif  // DEVICEMANAGER_H