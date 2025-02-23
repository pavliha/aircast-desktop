// MainPage
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

Page {
    header: Header {}

    background: Rectangle {
        color: Theme.background
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Theme.spacing.lg
        spacing: Theme.spacing.lg

        TitleSection {}
        InfoBanner {}
        DeviceList {
            model: deviceManager.devices
        }
    }

    Component.onCompleted: deviceManager.fetchDevices()
}
