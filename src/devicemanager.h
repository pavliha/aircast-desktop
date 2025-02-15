#ifndef DEVICEMANAGER_H
#define DEVICEMANAGER_H

#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QObject>

class DeviceManager : public QObject {
  Q_OBJECT
  Q_PROPERTY(QVariantList devices READ devices NOTIFY devicesChanged)

 public:
  explicit DeviceManager(QObject *parent = nullptr);
  QVariantList devices() const { return m_devices; }

 public slots:
  void fetchDevices();

 signals:
  void devicesChanged();

 private slots:
  void handleNetworkReply(QNetworkReply *reply);

 private:
  QNetworkAccessManager *m_manager;
  QVariantList m_devices;
};

#endif  // DEVICEMANAGER_H