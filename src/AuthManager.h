// AuthManager.h
#pragma once

#include <QDesktopServices>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QObject>
#include <QQmlEngine>
#include <QTimer>
#include <QUrl>

class AuthManager : public QObject {
  Q_OBJECT

  Q_PROPERTY(bool isAuthenticated READ isAuthenticated NOTIFY authStatusChanged)
  Q_PROPERTY(QString userToken READ userToken NOTIFY userTokenChanged)
  Q_PROPERTY(QVariantMap userData READ userData NOTIFY userDataChanged)

 public:
  explicit AuthManager(QObject *parent = nullptr);

  bool isAuthenticated() const;
  QString userToken() const;
  QVariantMap userData() const;

  // This method will be called from QML
  Q_INVOKABLE void startGoogleSignIn();
  Q_INVOKABLE void signOut();

 signals:
  void authStatusChanged();
  void userTokenChanged();
  void userDataChanged();
  void signInSuccessful();
  void signInFailed(const QString &message);

 private slots:
  void onSessionTokenReceived(QNetworkReply *reply);
  void onPollTimerTimeout();

 private:
  void createAuthSession();
  void startPolling(const QString &token);
  void getUserProfile();

  QNetworkAccessManager *m_networkManager;
  QTimer *m_pollTimer;
  QString m_sessionToken;
  QString m_userToken;
  QVariantMap m_userData;
  bool m_isAuthenticated;

  // Base URL for your API
  const QString API_BASE_URL =
      "http://localhost:3333";  // Replace with your actual API URL
};