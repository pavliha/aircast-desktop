// ThemeManager.h
#pragma once
#include <QObject>
#include <QString>

class ThemeManager : public QObject {
  Q_OBJECT
  Q_PROPERTY(
      bool darkMode READ darkMode WRITE setDarkMode NOTIFY darkModeChanged)
  Q_PROPERTY(QString themeMode READ themeMode NOTIFY darkModeChanged)

 public:
  explicit ThemeManager(QObject *parent = nullptr);

  bool darkMode() const;
  void setDarkMode(bool dark);
  QString themeMode() const;
  Q_INVOKABLE void setThemeMode(const QString &mode);

 signals:
  void darkModeChanged();

 private:
  bool m_themeOverride = false;
  bool m_manualDarkMode = false;
};