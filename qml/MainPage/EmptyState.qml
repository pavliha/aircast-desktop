// EmptyState
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// import AircastDesktop 1.0

ColumnLayout {
    spacing: Theme.spacing.md

    Image {
        Layout.alignment: Qt.AlignHCenter
        source: "qrc:/AircastDesktop/assets/icons/plus-circle.svg"
        sourceSize: Qt.size(48, 48)
        width: 48
        height: 48
    }

    Label {
        Layout.alignment: Qt.AlignHCenter
        text: "No Devices Found"
        color: Theme.foreground
        font.pixelSize: 16
    }

    Label {
        Layout.alignment: Qt.AlignHCenter
        text: "Get started by adding your first device"
        color: Theme.mutedForeground
        font.pixelSize: 14
    }

    Button {
        Layout.alignment: Qt.AlignHCenter
        text: "Add Your First Device"

        background: Rectangle {
            color: Theme.primary
            radius: Theme.radius
            implicitWidth: 160
            implicitHeight: 36
        }

        contentItem: Text {
            text: parent.text
            color: Theme.primaryForeground
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
        }

        onClicked:
        // TODO: Implement add device functionality
        {}
    }
}
