// qml/ui/Header.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

ToolBar {
    id: header
    height: 64
    width: parent.width

    default property alias content: additionalContentContainer.children

    background: Rectangle {
        color: "transparent"
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

        // Container for additional content passed as children
        RowLayout {
            id: additionalContentContainer
            spacing: Theme.spacing.md
            Layout.alignment: Qt.AlignVCenter
        }

        ThemeToggleDropdown {
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
