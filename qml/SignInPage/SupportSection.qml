import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import myproject 1.0

RowLayout {
    Layout.fillWidth: true
    Layout.topMargin: 16
    Layout.alignment: Qt.AlignHCenter
    spacing: 8  // Increased spacing between text elements

    Text {
        text: "Need help?"
        color: Theme.mutedForeground
        font.pixelSize: 14
    }

    LinkText {
        text: "Contact Support"
        font.pixelSize: 14
        font.weight: Font.Medium
        hoverable: true
        onClicked: Qt.openUrlExternally("https://aircast.one/support")
    }
}
