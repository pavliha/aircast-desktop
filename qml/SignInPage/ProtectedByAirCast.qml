import QtQuick
import QtQuick.Layouts
import myproject 1.0

Item {
    id: root
    Layout.fillWidth: true
    Layout.preferredHeight: 40
    Layout.topMargin: 16
    Layout.bottomMargin: 16

    // Horizontal line
    Rectangle {
        id: line
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        height: 1
        color: Theme.withAlpha(Theme.border, 0.2)  // Subtle line color
    }

    // Background pill for text
    Rectangle {
        id: textBackground
        anchors.centerIn: parent
        width: protectedText.width + 16  // px-2 equivalent
        height: protectedText.height + 4
        color: Theme.card  // Match card background

        // The text itself
        Text {
            id: protectedText
            anchors.centerIn: parent
            text: "PROTECTED BY AIRCAST"
            color: Theme.mutedForeground
            font {
                pixelSize: 12  // text-xs equivalent
                weight: Font.Medium
                capitalization: Font.AllUppercase
            }
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
