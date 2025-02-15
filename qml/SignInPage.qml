// SignInPage.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Page {
  id: root
  signal signInSuccessful()

  background: Rectangle {
    color: "#000000"

    // Gradient overlay similar to React version
    Rectangle {
      anchors.fill: parent
      gradient: Gradient {
        GradientStop { position: 0.0; color: "#00000000" }
        GradientStop { position: 1.0; color: "#0A0A0A" }
      }
    }
  }

  ColumnLayout {
    anchors.centerIn: parent
    width: 480
    spacing: 0

    // Title Section
    ColumnLayout {
      Layout.fillWidth: true
      spacing: 8

      Text {
        Layout.fillWidth: true
        text: "Welcome to AirCast"
        color: "#FFFFFF"
        font.pixelSize: 48
        font.weight: Font.Medium
        horizontalAlignment: Text.AlignHCenter
      }

      Text {
        Layout.fillWidth: true
        text: "Stream and manage your devices with ease"
        color: "#94A3B8"
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
      }
    }

    // Sign In Card
    Rectangle {
      id: cardContainer
      Layout.fillWidth: true
      Layout.topMargin: 40
      Layout.preferredHeight: 320
      color: "#0F172A"
      radius: 16

      // Card border
      Rectangle {
        id: cardBorder
        anchors.fill: parent
        color: "transparent"
        radius: 16
        border.width: 1
        border.color: "#1E293B"
      }

      // Card shadow
      layer.enabled: true
      layer.effect: DropShadow {
        transparentBorder: true
        horizontalOffset: 0
        verticalOffset: 4
        radius: 24.0
        samples: 17
        color: "#00000088"
      }

      ColumnLayout {
        anchors.fill: parent
        anchors.margins: 32
        spacing: 0

        // Card Header
        ColumnLayout {
          Layout.fillWidth: true
          spacing: 8

          Text {
            Layout.fillWidth: true
            text: "Sign in"
            color: "#FFFFFF"
            font.pixelSize: 24
            font.weight: Font.Medium
            horizontalAlignment: Text.AlignHCenter
          }

          Text {
            Layout.fillWidth: true
            text: "Choose your preferred sign in method"
            color: "#94A3B8"
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
          }
        }

        // Google Button
        Rectangle {
          id: googleButton
          Layout.fillWidth: true
          Layout.topMargin: 24
          Layout.preferredHeight: 48
          color: "#000000"
          radius: 8

          // Button border
          Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: 8
            border.width: 1
            border.color: "#1E293B"
          }

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
            hoverEnabled: true
            onEntered: {
              googleButton.scale = 1.01
              googleButton.color = "#0F172A"
            }
            onExited: {
              googleButton.scale = 1.0
              googleButton.color = "#000000"
            }
          }

          Behavior on scale {
          NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
        }
        Behavior on color {
        ColorAnimation { duration: 150 }
      }
    }

    // Protected Text with Separator
    Rectangle {
      Layout.fillWidth: true
      Layout.topMargin: 40
      Layout.preferredHeight: 24
      color: "transparent"

      Rectangle {
        anchors.centerIn: parent
        width: parent.width
        height: 1
        color: "#1E293B"
      }

      Rectangle {
        anchors.centerIn: parent
        width: protectedText.width + 16
        height: 24
        color: "#0F172A"
      }

      Text {
        id: protectedText
        anchors.centerIn: parent
        text: "PROTECTED BY AIRCAST"
        color: "#475569"
        font.pixelSize: 12
        font.weight: Font.Medium
      }
    }

    // Terms Text
    Text {
      Layout.fillWidth: true
      Layout.topMargin: 16
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
          hoverEnabled: true
          onEntered: parent.color = "#94A3B8"
          onExited: parent.color = "#FFFFFF"
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
          hoverEnabled: true
          onEntered: parent.color = "#94A3B8"
          onExited: parent.color = "#FFFFFF"
        }
      }
    }
  }
}

// Support Section
RowLayout {
  Layout.fillWidth: true
  Layout.topMargin: 24
  spacing: 4
  Layout.alignment: Qt.AlignHCenter

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
      hoverEnabled: true
      onEntered: parent.color = "#94A3B8"
      onExited: parent.color = "#FFFFFF"
    }
  }
}
}
}