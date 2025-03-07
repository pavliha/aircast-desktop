// ThemeChecker.h
#pragma once
#include <QGuiApplication>
#include <QObject>
#include <QPalette>
#include <QSettings>
#include <QStyleHints>

class ThemeChecker : public QObject {
  Q_OBJECT
  Q_PROPERTY(
      bool darkMode READ darkMode WRITE setDarkMode NOTIFY darkModeChanged)
  Q_PROPERTY(QString themeMode READ themeMode NOTIFY darkModeChanged)

 public:
  explicit ThemeChecker(QObject *parent = nullptr) : QObject(parent) {
    QSettings settings;
    m_themeOverride = settings.value("theme/override", false).toBool();
    m_manualDarkMode = settings.value("theme/darkMode", false).toBool();
  }

  bool darkMode() const {
    if (m_themeOverride) {
      return m_manualDarkMode;
    }

    // Use system theme if no override
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

  void setDarkMode(bool dark) {
    if (m_manualDarkMode == dark && m_themeOverride) return;

    m_themeOverride = false;
    m_manualDarkMode = dark;

    QSettings settings;
    settings.setValue("theme/override", m_themeOverride);
    settings.setValue("theme/darkMode", m_manualDarkMode);

    emit darkModeChanged();
  }

  QString themeMode() const {
    if (m_themeOverride) {
      return m_manualDarkMode ? "Dark" : "Light";
    }
    return "System";
  }

  Q_INVOKABLE void setThemeMode(const QString &mode) {
    qDebug() << "setThemeMode called with:" << mode;

    if (mode == "System") {
      m_themeOverride = false;
      QSettings settings;
      settings.setValue("theme/override", false);
      emit darkModeChanged();
    } else if (mode == "Light") {
      m_themeOverride = true;  // Set override to true
      m_manualDarkMode = false;
      QSettings settings;
      settings.setValue("theme/override", true);
      settings.setValue("theme/darkMode", false);
      emit darkModeChanged();
    } else if (mode == "Dark") {
      m_themeOverride = true;  // Set override to true
      m_manualDarkMode = true;
      QSettings settings;
      settings.setValue("theme/override", true);
      settings.setValue("theme/darkMode", true);
      emit darkModeChanged();
    }
  }

 signals:
  void darkModeChanged();

 private:
  bool m_themeOverride = false;
  bool m_manualDarkMode = false;
};