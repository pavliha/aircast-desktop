// InfoBanner
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// import AircastDesktop 1.0

Rectangle {
    Layout.fillWidth: true
    height: Theme.spacing.xxxl - Theme.spacing.sm
    color: Theme.secondary
    radius: Theme.radius

    RowLayout {
        anchors.fill: parent
        anchors.margins: Theme.spacing.md
        spacing: Theme.spacing.xs

        Image {
            source: "qrc:/AircastDesktop/assets/icons/info.svg"
            width: 20
            height: 20
        }

        Label {
            text: "Connect to your devices to start streaming or click the settings icon to configure them."
            color: Theme.secondaryForeground
            font.pixelSize: 14
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }
    }
}
