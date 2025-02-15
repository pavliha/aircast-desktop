import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: root
  Layout.fillWidth: true
  Layout.fillHeight: true
  color: "#0d0f10"
  radius: 6

  property alias model: listView.model

    EmptyState {
      anchors.centerIn: parent
      visible: listView.count === 0
    }

    ListView {
      id: listView
      anchors.fill: parent
      anchors.margins: 10
      spacing: 8
      clip: true
      visible: listView.count > 0

      delegate: DeviceDelegate {}
    }
  }