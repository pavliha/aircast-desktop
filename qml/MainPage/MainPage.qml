// qml/MainPage/MainPage.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

Page {
    id: root

    header: Header {
        UserMenuDropdown {}
    }

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
