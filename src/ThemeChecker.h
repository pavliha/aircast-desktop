#pragma once
#include <QGuiApplication>
#include <QObject>
#include <QPalette>
#include <QStyleHints>

class ThemeChecker : public QObject {
  Q_OBJECT
  Q_PROPERTY(bool darkMode READ darkMode CONSTANT)
 public:
  explicit ThemeChecker(QObject *parent = nullptr) : QObject(parent) {}

  bool darkMode() const {
#if QT_VERSION >= QT_VERSION_CHECK(6, 5, 0)
    const auto scheme = QGuiApplication::styleHints()->colorScheme();
    return scheme == Qt::ColorScheme::Dark;
#else
    const QPalette defaultPalette;
    const auto text = defaultPalette.color(QPalette::WindowText);
    const auto window = defaultPalette.color(QPalette::Window);
    return text.lightness() > window.lightness();
#endif
  }
};
