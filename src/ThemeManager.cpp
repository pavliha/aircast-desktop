// ThemeManager.cpp
#include "ThemeManager.h"

#include <QDebug>
#include <QGuiApplication>
#include <QPalette>
#include <QSettings>
#include <QStyleHints>

ThemeManager::ThemeManager(QObject *parent) : QObject(parent) {
  QSettings settings;
  m_themeOverride = settings.value("theme/override", false).toBool();
  m_manualDarkMode = settings.value("theme/darkMode", false).toBool();
}

bool ThemeManager::darkMode() const {
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

void ThemeManager::setDarkMode(bool dark) {
  if (m_manualDarkMode == dark && m_themeOverride) return;

  m_themeOverride = true;  // Changed this to set override to true when manually
                           // setting dark mode
  m_manualDarkMode = dark;

  QSettings settings;
  settings.setValue("theme/override", m_themeOverride);
  settings.setValue("theme/darkMode", m_manualDarkMode);

  emit darkModeChanged();
}

QString ThemeManager::themeMode() const {
  if (m_themeOverride) {
    return m_manualDarkMode ? "Dark" : "Light";
  }
  return "System";
}

void ThemeManager::setThemeMode(const QString &mode) {
  if (mode == "System") {
    m_themeOverride = false;
    QSettings settings;
    settings.setValue("theme/override", false);
    emit darkModeChanged();
  } else if (mode == "Light") {
    m_themeOverride = true;
    m_manualDarkMode = false;
    QSettings settings;
    settings.setValue("theme/override", true);
    settings.setValue("theme/darkMode", false);
    emit darkModeChanged();
  } else if (mode == "Dark") {
    m_themeOverride = true;
    m_manualDarkMode = true;
    QSettings settings;
    settings.setValue("theme/override", true);
    settings.setValue("theme/darkMode", true);
    emit darkModeChanged();
  }
}