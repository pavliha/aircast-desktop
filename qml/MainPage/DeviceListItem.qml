// DeviceListItem.qml
import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import AircastDesktop 1.0

Rectangle {
    id: root
    width: ListView.view.width
    height: 72
    color: Theme.card
    radius: Theme.radius
    border.width: 1
    border.color: Theme.border

    // Properties to receive data from parent
    property string deviceName: ""
    property string deviceId: ""
    property string lastSeenTime: ""

    signal connectClicked
    signal settingsClicked

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Theme.spacing.md
        anchors.rightMargin: Theme.spacing.md
        spacing: Theme.spacing.md

        // Device name
        Controls.Label {
            text: deviceName || "Unnamed Device"
            color: Theme.cardForeground
            font.pixelSize: 16
            font.weight: Font.Medium
            Layout.alignment: Qt.AlignVCenter
        }

        // Status Badge - right next to the device name
        StatusBadge {
            lastSeenTime: root.lastSeenTime
            Layout.alignment: Qt.AlignVCenter
        }

        // Spacer
        Item {
            Layout.fillWidth: true
        }

        // Right side: Action buttons
        Row {
            spacing: Theme.spacing.md
            Layout.alignment: Qt.AlignVCenter

            // Connect button
            Button {
                text: "Connect"
                variant: "secondary"

                onClicked: {
                    root.connectClicked();
                }
            }

            // Settings button
            Button {
                variant: "ghost"
                size: "icon"

                contentItem: Icon {
                    source: "qrc:/AircastDesktop/assets/icons/settings.svg"
                    color: Theme.foreground
                    size: 16
                    anchors.centerIn: parent
                }

                onClicked: {
                    root.settingsClicked();
                }
            }
        }
    }

    // Transitions
    Behavior on color {
        ColorAnimation {
            duration: 150
            easing.type: Easing.OutQuad
        }
    }
}
