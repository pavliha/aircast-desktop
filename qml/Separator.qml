import QtQuick
import QtQuick.Layouts
import AircastDesktop 1.0

Rectangle {
    id: root
    Layout.fillWidth: true
    height: Theme.spacing.md
    color: "transparent"

    property alias text: labelText.text

    Rectangle {
        anchors.centerIn: parent
        width: parent.width
        height: 1
        color: Theme.border
    }

    Rectangle {
        anchors.centerIn: parent
        width: labelText.width + Theme.spacing.md
        height: labelText.height
        color: Theme.background
    }

    Text {
        id: labelText
        anchors.centerIn: parent
        color: Theme.mutedForeground
        font.pixelSize: 12
        font.weight: Font.Medium
    }
}
