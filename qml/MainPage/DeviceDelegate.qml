// DeviceDelegate.qml
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

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Theme.spacing.md
        anchors.rightMargin: Theme.spacing.md
        spacing: Theme.spacing.md

        // Left column: Device name and last seen
        Column {
            spacing: 8
            Layout.alignment: Qt.AlignVCenter

            // Device name
            Label {
                text: modelData.name || "Unnamed Device"
                color: Theme.cardForeground
                font.pixelSize: 14
                font.weight: Font.Medium
            }

            // Last seen indicator
            Row {
                spacing: 6

                // Status dot
                Rectangle {
                    width: 8
                    height: 8
                    radius: 4
                    color: Theme.mutedForeground
                    anchors.verticalCenter: parent.verticalCenter
                }

                // Last seen text
                Label {
                    text: {
                        const lastSeenTime = modelData.last_seen_at || modelData.lastSeenAt;
                        if (!lastSeenTime)
                            return "";

                        const lastSeen = new Date(lastSeenTime);
                        const now = new Date();
                        const diffMs = now - lastSeen;
                        const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));

                        if (diffDays > 30) {
                            const months = Math.floor(diffDays / 30);
                            return months + " days ago";
                        } else if (diffDays > 0) {
                            return diffDays + " days ago";
                        } else {
                            const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
                            if (diffHours > 0) {
                                return diffHours + " hours ago";
                            } else {
                                return "Just now";
                            }
                        }
                    }
                    color: Theme.mutedForeground
                    font.pixelSize: 12
                }
            }
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
                    console.log("Connect to device: " + modelData.id);
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
                    console.log("Open settings for device: " + modelData.id);
                }
            }
        }
    }
}
