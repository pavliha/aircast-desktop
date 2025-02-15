// SignInPage.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
  id: root
  signal signInSuccessful()

  background: Rectangle {
    color: "#000000"
  }

  ColumnLayout {
    anchors.centerIn: parent
    width: 480
    spacing: 0

    // Welcome Text
    Text {
      Layout.fillWidth: true
      text: "Welcome to AirCast"
      color: "#FFFFFF"
      font.pixelSize: 48
      font.weight: Font.SemiBold
      horizontalAlignment: Text.AlignHCenter
    }

    // Subtitle
    Text {
      Layout.fillWidth: true
      Layout.topMargin: 12
      Layout.bottomMargin: 40
      text: "Stream and manage your devices with ease"
      color: "#94A3B8"
      font.pixelSize: 16
      horizontalAlignment: Text.AlignHCenter
    }

    // Sign In Card
    Rectangle {
      Layout.fillWidth: true
      Layout.preferredHeight: 300
      color: "#0F172A"
      radius: 16

      ColumnLayout {
        anchors.fill: parent
        anchors.margins: 32
        spacing: 0

        // Sign in title
        Text {
          Layout.fillWidth: true
          text: "Sign in"
          color: "#FFFFFF"
          font.pixelSize: 24
          font.weight: Font.Medium
          horizontalAlignment: Text.AlignHCenter
        }

        // Sign in subtitle
        Text {
          Layout.fillWidth: true
          Layout.topMargin: 8
          Layout.bottomMargin: 24
          text: "Choose your preferred sign in method"
          color: "#94A3B8"
          font.pixelSize: 14
          horizontalAlignment: Text.AlignHCenter
        }

        // Google Sign In Button
        Rectangle {
          Layout.fillWidth: true
          Layout.preferredHeight: 48
          color: "#000000"
          radius: 8

          RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            spacing: 12

            Image {
              source: "qrc:/myproject/assets/icons/google.svg"
              sourceSize.width: 24
              sourceSize.height: 24
            }

            Text {
              text: "Continue with Google"
              color: "#FFFFFF"
              font.pixelSize: 14
              font.weight: Font.Medium
            }

            Item { Layout.fillWidth: true }
          }

          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.signInSuccessful()
          }
        }

        // Protected by AirCast
        Text {
          Layout.fillWidth: true
          Layout.topMargin: 40
          text: "PROTECTED BY AIRCAST"
          color: "#475569"
          font.pixelSize: 12
          font.weight: Font.Medium
          horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
          Layout.fillWidth: true
          Layout.preferredHeight: 1
          Layout.topMargin: 16
          Layout.bottomMargin: 16
          color: "#1E293B"
        }

        // Terms text
        ColumnLayout {
          Layout.fillWidth: true
          spacing: 0

          Text {
            Layout.fillWidth: true
            text: "By clicking continue, you agree to our"
            color: "#64748B"
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
          }

          RowLayout {
            Layout.fillWidth: true
            Layout.topMargin: 4
            spacing: 4
            Layout.alignment: Qt.AlignHCenter

            Text {
              text: "Terms of Service"
              color: "#FFFFFF"
              font.pixelSize: 12
              font.underline: true

              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
              }
            }

            Text {
              text: "and"
              color: "#64748B"
              font.pixelSize: 12
            }

            Text {
              text: "Privacy Policy"
              color: "#FFFFFF"
              font.pixelSize: 12
              font.underline: true

              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
              }
            }
          }
        }
      }
    }

    // Contact Support
    RowLayout {
      Layout.fillWidth: true
      Layout.topMargin: 24
      Layout.alignment: Qt.AlignHCenter
      spacing: 4

      Text {
        text: "Need help?"
        color: "#64748B"
        font.pixelSize: 14
      }

      Text {
        text: "Contact Support"
        color: "#FFFFFF"
        font.pixelSize: 14
        font.weight: Font.Medium

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
        }
      }
    }
  }
}