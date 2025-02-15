import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    width: 1200
    height: 800
    visible: true
    title: "AirCast"
    color: "#000000"

    header: Header {}

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        TitleSection {}
        InfoBanner {}
        DeviceList {
            model: deviceManager.devices
        }
    }

    Component.onCompleted: deviceManager.fetchDevices()
}