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
  Q_PROPERTY(QString apiBaseUrl READ apiBaseUrl WRITE setApiBaseUrl NOTIFY
                 apiBaseUrlChanged)

 public:
  explicit DeviceManager(QObject *parent = nullptr);

  QVariantList devices() const { return m_devices; }
  QString apiBaseUrl() const { return m_apiBaseUrl; }

 public slots:
  void fetchDevices();
  void setAuthManager(AuthManager *authManager);
  void setApiBaseUrl(const QString &url);

 signals:
  void devicesChanged();
  void apiBaseUrlChanged();
  void error(const QString &message);

 private slots:
  void handleNetworkReply(QNetworkReply *reply);
  void onAuthStatusChanged();

 private:
  QNetworkAccessManager *m_networkManager;
  QVariantList m_devices;
  AuthManager *m_authManager = nullptr;
  QString m_apiBaseUrl;
};

#endif  // DEVICEMANAGER_H