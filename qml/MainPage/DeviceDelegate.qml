import QtQuick 2.15
import QtQuick.Controls 6.5
import QtQuick.Layouts

Rectangle {
    width: ListView.view.width
    height: 70
    color: "#1a1d21"
    radius: 4

    RowLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 15

        Label {
            text: modelData.name || "Unnamed Device"
            color: "white"
            font.pixelSize: 14
        }

        Item {
            Layout.fillWidth: true
        }

        Button {
            text: "Settings"
            icon.source: "qrc:/assets/icons/settings.svg"
            onClicked:
            // TODO: Implement settings functionality
            {}
        }
    }
}
