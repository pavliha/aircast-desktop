import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import AircastDesktop 1.0

Controls.Page {
    id: root

    // Properties to receive device data
    property string deviceId: ""

    // Get the device name from the DeviceManager
    property string deviceName: {
        if (deviceId) {
            var device = deviceManager.getDeviceById(deviceId);
            return device.name || "Unnamed Device";
        }
        return "Device";
    }

    signal backRequested

    header: Header {
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: Theme.spacing.md

            // Back button
            Button {
                variant: "ghost"
                size: "icon"

                contentItem: Icon {
                    source: "qrc:/AircastDesktop/assets/icons/arrow-left.svg"
                    color: Theme.foreground
                    size: 16
                    anchors.centerIn: parent
                }

                onClicked: {
                    root.backRequested();
                }
            }

            // Page title
            Controls.Label {
                text: deviceName
                font.pixelSize: 18
                font.weight: Font.Medium
                color: Theme.foreground
                Layout.leftMargin: Theme.spacing.sm
            }

            Item {
                Layout.fillWidth: true
            }

            UserMenuDropdown {}
        }
    }

    background: PageBackground {}

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Theme.spacing.lg
        spacing: Theme.spacing.lg

        // Device connection status
        Rectangle {
            Layout.fillWidth: true
            height: 80
            color: Theme.success + "20"  // Semi-transparent success color
            radius: Theme.radius
            border.width: 1
            border.color: Theme.success

            RowLayout {
                anchors.fill: parent
                anchors.margins: Theme.spacing.md
                spacing: Theme.spacing.md

                Icon {
                    source: "qrc:/AircastDesktop/assets/icons/check-circle.svg"
                    color: Theme.success
                    size: 24
                }

                ColumnLayout {
                    spacing: Theme.spacing.xs

                    Controls.Label {
                        text: "Connected to " + deviceName
                        font.pixelSize: 16
                        font.weight: Font.Medium
                        color: Theme.success
                    }

                    Controls.Label {
                        text: "Your device is now ready to receive content"
                        font.pixelSize: 14
                        color: Theme.foreground
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                Button {
                    text: "Disconnect"
                    variant: "outline"

                    onClicked: {
                        // Handle disconnect logic here
                        root.backRequested();
                    }
                }
            }
        }

        // Content Area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Theme.card
            radius: Theme.radius
            border.width: 1
            border.color: Theme.border

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: Theme.spacing.lg
                spacing: Theme.spacing.lg

                Controls.Label {
                    text: "Device Control"
                    font.pixelSize: 20
                    font.weight: Font.Medium
                    color: Theme.cardForeground
                }

                // Device controls will go here
                Controls.Label {
                    text: "Device ID: " + deviceId
                    color: Theme.cardForeground
                }

                // Spacer
                Item {
                    Layout.fillHeight: true
                }
            }
        }
    }
}
