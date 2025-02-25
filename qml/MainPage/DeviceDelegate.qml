import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

Rectangle {
    width: ListView.view.width
    height: Theme.spacing.xxxl + Theme.spacing.xs // 72px
    color: Theme.secondary
    radius: Theme.radius

    RowLayout {
        anchors.fill: parent
        anchors.margins: Theme.spacing.md
        spacing: Theme.spacing.md

        Label {
            text: modelData.name || "Unnamed Device"
            color: Theme.foreground
            font.pixelSize: 14
            font.weight: Font.Medium
        }

        Item {
            Layout.fillWidth: true
        }

        Button {
            size: "icon"
            variant: "ghost"
            contentItem: Icon {
                source: "qrc:/AircastDesktop/assets/icons/settings.svg"
                color: Theme.foreground
                width: 16
                height: 16
            }
        }
    }
}
