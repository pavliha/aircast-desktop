import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import myproject 1.0

Page {
    id: root
    signal signInSuccessful

    background: Rectangle {
        anchors.fill: parent
        color: Theme.background
        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop {
                position: 0.0
                color: Theme.isDark ? Theme.card : Theme.background
            }
            GradientStop {
                position: 1.0
                color: Theme.background
            }
        }
    }

    Rectangle {
        id: container
        anchors.centerIn: parent
        // Enforce a max width of 480 or (parent.width - 32) if screen is small
        width: Math.min(parent.width - 32, 480)
        height: contentLayout.implicitHeight
        // Use transparent color since we want to see the background gradient
        color: "transparent"

        ColumnLayout {
            id: contentLayout
            anchors.centerIn: parent
            width: parent.width
            spacing: 32

            BrandSection {
                Layout.fillWidth: true
            }

            SignInCard {
                Layout.fillWidth: true
                onSignInSuccessful: root.signInSuccessful()
            }

            SupportSection {
                Layout.fillWidth: true
            }
        }
    }
}
