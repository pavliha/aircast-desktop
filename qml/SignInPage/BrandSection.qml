import QtQuick 2.15
import QtQuick.Layouts 1.3
import myproject 1.0

ColumnLayout {
    Layout.fillWidth: true
    spacing: 8

    Text {
        Layout.fillWidth: true
        text: "Welcome to AirCast"
        color: Theme.foreground
        font {
            pixelSize: 36
            weight: Font.Bold
            letterSpacing: -0.5  // tracking-tight equivalent
        }
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        Layout.fillWidth: true
        text: "Stream and manage your devices with ease"
        color: Theme.mutedForeground
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
    }
}
