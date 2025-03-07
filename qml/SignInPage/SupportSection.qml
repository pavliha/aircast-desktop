import QtQuick
import QtQuick.Layouts
import AircastDesktop 1.0

RowLayout {
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter

    Text {
        text: "Need help?"
        color: Theme.mutedForeground
        font.pixelSize: 14
    }

    Link {
        text: "Contact Support"
        font.pixelSize: 14
        font.weight: Font.Medium
        hoverable: true
        onClicked: Qt.openUrlExternally("https://aircast.one/support")
    }
}
