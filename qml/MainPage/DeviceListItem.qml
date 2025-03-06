// DeviceListItem.qml
import QtQuick
import QtQuick.Controls
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
        Label {
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

                contentItem: Image {
                    source: "qrc:/AircastDesktop/assets/icons/settings.svg"
                    width: 16
                    height: 16
                    anchors.centerIn: parent
                    sourceSize.width: 16
                    sourceSize.height: 16
                }

                onClicked: {
                    root.settingsClicked();
                }
            }
        }
    }

    // Hover effect
    Rectangle {
        id: hoverBackground
        anchors.fill: parent
        radius: parent.radius
        color: Theme.withAlpha(Theme.accent, 0.5)
        visible: false
        z: -1
    }

    // Mouse area just for hover, not for click handling
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: hoverBackground.visible = true
        onExited: hoverBackground.visible = false
        propagateComposedEvents: true // Allow click events to pass through
        onClicked: mouse.accepted = false // Don't handle clicks
        onPressed: mouse.accepted = false // Don't handle press events
        onReleased: mouse.accepted = false // Don't handle release events
    }

    // Transitions
    Behavior on color {
        ColorAnimation {
            duration: 150
            easing.type: Easing.OutQuad
        }
    }
}
