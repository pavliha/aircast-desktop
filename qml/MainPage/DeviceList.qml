// DeviceList.qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import AircastDesktop 1.0

Item {
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true

    property alias model: listView.model

    signal deviceConnectClicked(string deviceId)
    signal deviceSettingsClicked(string deviceId)

    // Empty state when no devices
    EmptyState {
        anchors.centerIn: parent
        visible: listView.count === 0
    }

    ListView {
        id: listView
        anchors.fill: parent
        spacing: Theme.spacing.md
        clip: true
        visible: listView.count > 0

        delegate: DeviceListItem {
            deviceName: modelData.name || ""
            deviceId: modelData.id || ""
            lastSeenTime: modelData.last_seen_at || modelData.lastSeenAt || ""

            onConnectClicked: {
                root.deviceConnectClicked(deviceId);
            }

            onSettingsClicked: {
                root.deviceSettingsClicked(deviceId);
            }
        }

        // Add scrollbar if needed
        Controls.ScrollBar.vertical: Controls.ScrollBar {
            active: listView.movingVertically
            policy: listView.contentHeight > listView.height ? Controls.ScrollBar.AlwaysOn : Controls.ScrollBar.AsNeeded
        }
    }
}
