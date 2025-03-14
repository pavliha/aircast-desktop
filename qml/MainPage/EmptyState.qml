// EmptyState
import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import AircastDesktop 1.0

ColumnLayout {
    spacing: Theme.spacing.md

    Icon {
        Layout.alignment: Qt.AlignHCenter
        source: "qrc:/AircastDesktop/assets/icons/plus-circle.svg"
        color: Theme.mutedForeground
        width: 48
        height: 48
    }

    Controls.Label {
        Layout.alignment: Qt.AlignHCenter
        text: "No Devices Found"
        color: Theme.foreground
        font.pixelSize: 16
        font.weight: Font.Medium
    }

    Controls.Label {
        Layout.alignment: Qt.AlignHCenter
        text: "Get started by adding your first device"
        color: Theme.mutedForeground
        font.pixelSize: 14
    }

    Button {
        Layout.alignment: Qt.AlignHCenter
        text: "Add Your First Device"
        variant: "default"
        onClicked:
        // TODO: Implement add device functionality
        {}
    }
}
