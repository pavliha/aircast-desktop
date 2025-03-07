// main.cpp
#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QtCore/QString>

#include "AuthManager.h"
#include "DeviceManager.h"
#include "ThemeManager.h"

using namespace Qt::StringLiterals;

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);
  app.setOrganizationName("Aircast");
  app.setOrganizationDomain("aircast.one");
  app.setApplicationName("AircastDesktop");

  // For displaying debug logs
  qDebug() << "Starting Aircast Desktop...";

  // Set Material theme
  QQuickStyle::setStyle("Material");

  // Create instances of our C++ classes
  AuthManager *authManager = new AuthManager(&app);
  DeviceManager *deviceManager = new DeviceManager(&app);
  ThemeManager *themeManager = new ThemeManager(&app);

  // Connect the AuthManager to DeviceManager
  deviceManager->setAuthManager(authManager);

  // Create QML Engine
  QQmlApplicationEngine engine;

  // Expose C++ objects to QML
  engine.rootContext()->setContextProperty("authManager", authManager);
  engine.rootContext()->setContextProperty("deviceManager", deviceManager);
  engine.rootContext()->setContextProperty("themeManager", themeManager);

  // Load main QML file
  const QUrl url(u"qrc:/AircastDesktop/qml/main.qml"_s);
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreated, &app,
      [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) QCoreApplication::exit(-1);
      },
      Qt::QueuedConnection);
  engine.load(url);

  return app.exec();
}