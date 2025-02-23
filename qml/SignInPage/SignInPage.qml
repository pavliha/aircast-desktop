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

    ColumnLayout {
        id: contentLayout
        width: Math.min(parent.width - Theme.spacing.lg, 480)
        spacing: 48

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
