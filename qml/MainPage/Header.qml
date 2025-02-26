import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

ToolBar {
    id: header
    height: 64
    width: parent.width

    background: Rectangle {
        color: Theme.background
    }

    RowLayout {
        anchors.fill: parent
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

        ThemeToggleDropdown {
            Layout.alignment: Qt.AlignVCenter
        }

        UserMenuDropdown {
            Layout.alignment: Qt.AlignVCenter
        }
    }
}