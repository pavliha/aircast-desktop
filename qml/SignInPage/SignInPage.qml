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

    // Main content container
    ColumnLayout {
        // Center horizontally and vertically with some padding
        anchors {
            centerIn: parent
            topMargin: 48
            bottomMargin: 48
        }
        width: Math.min(parent.width - 32, 480)
        spacing: 32  // Increased spacing between major sections

        BrandSection {}

        SignInCard {
            Layout.fillWidth: true
            Layout.preferredHeight: implicitHeight
        }

        SupportSection {}
    }
}
