import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ToolBar {
    background: Rectangle {
        color: "#000000"
    }
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        Label {
            text: "AirCast"
            color: "white"
            font.pixelSize: 18
            font.weight: Font.Medium
        }

        Item {
            Layout.fillWidth: true
        }

        Button {
            icon.source: "qrc:/AircastDesktop/assets/icons/theme.svg"
            flat: true
            background: Rectangle {
                color: "transparent"
            }
        }

        Label {
            text: "Pavlo Kostiuk"
            color: "white"
            font.pixelSize: 14
        }

        RoundButton {
            icon.source: "qrc:/AircastDesktop/assets/icons/circle-user.svg"
            flat: true
        }
    }
}
