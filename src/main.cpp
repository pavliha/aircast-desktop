#include <QDirIterator>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QtCore/QtCore>

#include "devicemanager.h"

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;
  QQuickStyle::setStyle("Basic");

  DeviceManager deviceManager;
  engine.rootContext()->setContextProperty("deviceManager", &deviceManager);

  engine.addImportPath("qrc:///");
  engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");

  const QUrl url(QStringLiteral("qrc:/myproject/qml/main.qml"));
  engine.load(url);

  if (engine.rootObjects().isEmpty()) {
    return -1;
  }

  return app.exec();
}