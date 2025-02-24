import QtQuick
import QtQuick.Layouts
import AircastDesktop 1.0

Rectangle {
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: Theme.card
    radius: Theme.radius
    border.width: 1
    border.color: Theme.border

    property alias model: listView.model

    EmptyState {
        anchors.centerIn: parent
        visible: listView.count === 0
    }

    ListView {
        id: listView
        anchors.fill: parent
        anchors.margins: Theme.spacing.md
        spacing: Theme.spacing.sm
        clip: true
        visible: listView.count > 0

        delegate: DeviceDelegate {}
    }
}
