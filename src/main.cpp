// main.cpp
#include <QDirIterator>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QtCore/QtCore>

#include "AuthManager.h"
#include "DeviceManager.h"
#include "ThemeChecker.h"

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);

  // Set application information for QSettings
  app.setOrganizationName("Aircast");
  app.setOrganizationDomain("aircast.one");
  app.setApplicationName("AircastDesktop");

  // Create instances of managers
  AuthManager authManager;
  DeviceManager deviceManager;

  // Connect device manager to auth manager
  deviceManager.setAuthManager(&authManager);

  // Create the QML engine
  QQmlApplicationEngine engine;

  // Register ThemeChecker as singleton
  ThemeChecker themeChecker;
  qmlRegisterSingletonInstance("AircastDesktop", 1, 0, "ThemeChecker",
                               &themeChecker);

  // Register the AuthManager type
  qmlRegisterType<AuthManager>("AircastDesktop", 1, 0, "AuthManager");

  QQuickStyle::setStyle("Basic");

  // Expose context properties
  engine.rootContext()->setContextProperty("deviceManager", &deviceManager);

  engine.addImportPath("qrc:///");
  engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");

  const QUrl url(QStringLiteral("qrc:/AircastDesktop/qml/main.qml"));
  engine.load(url);

  if (engine.rootObjects().isEmpty()) {
    return -1;
  }

  return app.exec();
}