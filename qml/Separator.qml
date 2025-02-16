import QtQuick
import QtQuick.Layouts

Rectangle {
  id: root
  Layout.fillWidth: true
  height: 24
  color: "transparent"

  property alias text: labelText.text

    Rectangle {
      anchors.centerIn: parent
      width: parent.width
      height: 1
      color: "#27272A"
    }

    Rectangle {
      anchors.centerIn: parent
      width: labelText.width + 16
      height: labelText.height
      color: "#0C0A0B"
    }

    Text {
      id: labelText
      anchors.centerIn: parent
      color: "#94A3B8"
      font.pixelSize: 12
      font.weight: Font.Medium
    }
  }