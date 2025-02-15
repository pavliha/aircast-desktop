#include <QDirIterator>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtCore/QtCore>

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;

  const QUrl url(QStringLiteral("qrc:/myproject/myproject/qml/main.qml"));

  engine.load(url);

  if (engine.rootObjects().isEmpty()) {
    return -1;
  }

  return app.exec();
}