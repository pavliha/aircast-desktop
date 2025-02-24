import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

ToolBar {
    id: header
    height: 64
    width: parent.width  // Make ToolBar take full width

    background: Rectangle {
        color: Theme.background
    }

    RowLayout {
        anchors.fill: parent  // This ensures the RowLayout fills the ToolBar
        anchors.leftMargin: Theme.spacing.lg
        anchors.rightMargin: Theme.spacing.lg
        spacing: Theme.spacing.md

        RowLayout {
            spacing: Theme.spacing.md

            Label {
                text: "AirCast"
                color: Theme.foreground
                font.pixelSize: 18
                font.weight: Font.Medium
            }
        }

        Item {
            Layout.fillWidth: true
        }

        Button {
            size: "icon"
            variant: "outline"
            contentItem: TintedIcon {
                source: "qrc:/AircastDesktop/assets/icons/theme.svg"
                tintColor: Theme.foreground
                width: 20
                height: 20
            }
        }

        Label {
            text: "Pavlo Kostiuk"
            color: Theme.foreground
            font.weight: Font.Medium
            font.pixelSize: 14
        }

        Button {
            size: "icon"
            variant: "ghost"
            contentItem: TintedIcon {
                source: "qrc:/AircastDesktop/assets/icons/circle-user.svg"
                tintColor: Theme.foreground
                width: 24
                height: 24
            }
        }
    }
}
