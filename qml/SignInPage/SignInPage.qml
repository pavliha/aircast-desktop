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
                color: "#121212"
            }
            GradientStop {
                position: 1.0
                color: "#0D0D0D"
            }
        }
    }

    // This Rectangle is our main container with a max width of 480
    Rectangle {
        id: container
        anchors.centerIn: parent
        // Enforce a max width of 480 or (parent.width - 32) if screen is small
        width: Math.min(parent.width - 32, 480)
        height: contentLayout.implicitHeight
        color: "transparent"

        ColumnLayout {
            id: contentLayout
            anchors.centerIn: parent
            Layout.fillWidth: true
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
