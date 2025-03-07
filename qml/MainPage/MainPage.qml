// qml/MainPage/MainPage.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

Page {
    id: root

    property var user: ({})

    signal deviceConnectRequested(string deviceId)

    header: Header {
        UserMenuDropdown {
            userName: user && user["name"] ? user["name"] : ""
            userEmail: user && user["email"] ? user["email"] : ""
        }
    }

    background: PageBackground {}

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Theme.spacing.lg
        spacing: Theme.spacing.lg

        TitleSection {}
        InfoBanner {}
        DeviceList {
            model: deviceManager.devices
            onDeviceConnectClicked: function (deviceId) {
                deviceConnectRequested(deviceId);
            }
        }
    }

    Component.onCompleted: deviceManager.fetchDevices()
}
