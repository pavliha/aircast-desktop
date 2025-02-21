import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import myproject 1.0

Page {
    id: root
    signal signInSuccessful

    background: Rectangle {
        // For a solid dark background:
        color: Theme.background

        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop {
                position: 0.0
                color: "#121212"
            }
            GradientStop {
                position: 1.0
                color: "#0D0D0D"
            }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        width: Math.min(parent.width - 32, 480)
        spacing: 0

        // Brand Section (still visible, but with dark text)
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 8

            Text {
                Layout.fillWidth: true
                text: "Welcome to AirCast"
                color: Theme.foreground
                font.pixelSize: 36
                font.weight: Font.Bold
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                Layout.fillWidth: true
                text: "Stream and manage your devices with ease"
                color: Theme.mutedForeground
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // Sign In Card
        SignInCard {}
        // Support Section
        RowLayout {
            Layout.fillWidth: true
            Layout.topMargin: 16
            Layout.alignment: Qt.AlignHCenter
            spacing: 4

            Text {
                text: "Need help?"
                color: Theme.mutedForeground
                font.pixelSize: 14
            }

            LinkText {
                text: "Contact Support"
                font.pixelSize: 14
                font.weight: Font.Medium
                hoverable: true
                onClicked: Qt.openUrlExternally("https://aircast.one/support")
            }
        }
    }
}
