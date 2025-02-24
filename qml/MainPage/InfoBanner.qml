import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

Rectangle {
    Layout.fillWidth: true
    implicitHeight: contentLayout.implicitHeight + (Theme.spacing.md * 2)
    color: Theme.secondary
    radius: Theme.radius
    border.width: 1
    border.color: Theme.border

    RowLayout {
        id: contentLayout
        anchors.fill: parent
        anchors.margins: Theme.spacing.md
        spacing: Theme.spacing.sm

        TintedIcon {
            source: "qrc:/AircastDesktop/assets/icons/info.svg"
            tintColor: Theme.foreground
            width: 16
            height: 16
            Layout.alignment: Qt.AlignTop
        }

        Label {
            text: "Connect to your devices to start streaming or click the settings icon to configure them."
            color: Theme.foreground
            font.pixelSize: 14
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
