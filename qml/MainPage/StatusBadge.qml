// StatusBadge.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

Rectangle {
    id: root

    // Properties
    property string lastSeenTime: ""
    property bool isOnline: false

    // Match the style from the screenshots
    height: 28
    radius: height / 2
    color: Theme.withAlpha(Theme.secondary, 0.8)

    // Size that adapts to content
    implicitWidth: row.implicitWidth + 16 // Add some padding on the sides

    // Content
    Row {
        id: row
        anchors.centerIn: parent
        spacing: 6

        // Status dot
        Rectangle {
            width: 8
            height: 8
            radius: 4
            color: Theme.mutedForeground
            anchors.verticalCenter: parent.verticalCenter
        }

        // Status text
        Text {
            text: formatTimeAgo(root.lastSeenTime)
            font.pixelSize: 12
            font.weight: Font.Medium
            color: Theme.secondaryForeground
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // Function to format time ago, simplified to match screenshots
    function formatTimeAgo(timeString) {
        if (!timeString)
            return "Unknown";

        const lastSeen = new Date(timeString);
        const now = new Date();

        // Handle future dates
        if (lastSeen > now) {
            return "Just now";
        }

        const diffMs = now - lastSeen;
        const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
        const diffMonths = Math.floor(diffDays / 30);

        if (diffMonths > 0) {
            return diffMonths + (diffMonths === 1 ? " month ago" : " months ago");
        } else if (diffDays > 0) {
            return diffDays + (diffDays === 1 ? " day ago" : " days ago");
        } else {
            return "Today";
        }
    }
}
