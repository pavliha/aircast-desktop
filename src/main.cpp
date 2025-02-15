#include <QDirIterator>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtCore/QtCore>

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;

  // Debug available resources
  qDebug() << "Available resources:";
  QDirIterator it(":", QDirIterator::Subdirectories);
  while (it.hasNext()) {
    qDebug() << it.next();
  }

  const QUrl url(QStringLiteral("qrc:/myproject/qml/main.qml"));

  qDebug() << "Import paths:" << engine.importPathList();
  qDebug() << "Resource URL:" << url;

  engine.load(url);

  if (engine.rootObjects().isEmpty()) {
    qDebug() << "Failed to load QML file!";
    qDebug() << "Engine errors:" << engine.hasError();
    return -1;
  }

  return app.exec();
}