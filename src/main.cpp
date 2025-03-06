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

  // Create the QML engine first
  QQmlApplicationEngine engine;

  // Register types
  ThemeChecker themeChecker;
  qmlRegisterSingletonInstance("AircastDesktop", 1, 0, "ThemeChecker",
                               &themeChecker);

  // Manually register the AuthManager type - this is important
  qmlRegisterType<AuthManager>("AircastDesktop", 1, 0, "AuthManager");

  QQuickStyle::setStyle("Basic");

  // Create the context properties
  DeviceManager deviceManager;
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