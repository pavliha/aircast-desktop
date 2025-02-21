import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15
import myproject 1.0

Item {
    Layout.fillWidth: true
    Layout.preferredHeight: 40

    Rectangle {
        anchors.centerIn: parent
        width: parent.width
        height: 1
        color: Theme.border
    }

    Rectangle {
        anchors.centerIn: parent
        width: protectedText.width + 16
        height: protectedText.height
        color: Theme.card
    }

    Text {
        id: protectedText
        anchors.centerIn: parent
        text: "PROTECTED BY AIRCAST"
        color: Theme.mutedForeground
        font.pixelSize: 12
        font.weight: Font.Medium
    }
}
