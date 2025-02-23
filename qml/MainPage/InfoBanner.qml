import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    Layout.fillWidth: true
    height: 60
    color: "#1a1d21"
    radius: 6

    RowLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 10

        Image {
            source: "qrc:/AircastDesktop/assets/icons/info.svg"
            width: 20
            height: 20
        }

        Label {
            text: "Connect to your devices to start streaming or click the settings icon to configure them."
            color: "white"
            font.pixelSize: 14
        }
    }
}
