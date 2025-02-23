import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// import AircastDesktop 1.0

ToolBar {
    background: Rectangle {
        color: Theme.background
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Theme.spacing.lg
        anchors.rightMargin: Theme.spacing.lg

        Label {
            text: "AirCast"
            color: Theme.foreground
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
            color: Theme.mutedForeground
            font.pixelSize: 14
        }

        RoundButton {
            icon.source: "qrc:/AircastDesktop/assets/icons/circle-user.svg"
            icon.color: Theme.foreground
            flat: true
        }
    }
}
