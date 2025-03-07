// SignInPage.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

Page {
    id: root
    signal signInSuccessful

    header: Header {}

    background: PageBackground {}

    ColumnLayout {
        id: contentLayout
        anchors.centerIn: parent
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
