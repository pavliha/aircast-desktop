// qml/MainPage/MainPage.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

Page {
    id: root

    property var user: ({})

    header: Header {
        UserMenuDropdown {
            userName: user && user["name"] ? user["name"] : ""
            userEmail: user && user["email"] ? user["email"] : ""
        }
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
