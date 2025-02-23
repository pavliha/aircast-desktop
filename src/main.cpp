#include <QDirIterator>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QtCore/QtCore>

#include "DeviceManager.h"
#include "ThemeChecker.h"

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);

  ThemeChecker themeChecker;
  qmlRegisterSingletonInstance("AircastDesktop", 1, 0, "ThemeChecker",
                               &themeChecker);

  QQmlApplicationEngine engine;
  QQuickStyle::setStyle("Basic");

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