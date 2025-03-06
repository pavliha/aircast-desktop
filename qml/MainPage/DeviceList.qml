// DeviceList.qml
import QtQuick
import QtQuick.Layouts
import AircastDesktop 1.0

Item {
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true

    property alias model: listView.model

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

        delegate: DeviceDelegate {}

        // Add scrollbar if needed
        ScrollBar.vertical: ScrollBar {
            active: listView.movingVertically
            policy: listView.contentHeight > listView.height ? ScrollBar.AlwaysOn : ScrollBar.AsNeeded
        }
    }
}
