import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
  spacing: 15

  Image {
    Layout.alignment: Qt.AlignHCenter
    source: "qrc:/myproject/assets/icons/plus-circle.svg"
    width: 48
    height: 48
  }

  Label {
    Layout.alignment: Qt.AlignHCenter
    text: "No Devices Found"
    color: "white"
    font.pixelSize: 16
  }

  Label {
    Layout.alignment: Qt.AlignHCenter
    text: "Get started by adding your first device"
    color: "#888888"
    font.pixelSize: 14
  }

  Button {
    Layout.alignment: Qt.AlignHCenter
    text: "Add Your First Device"
    background: Rectangle {
      color: "white"
      radius: 4
      implicitWidth: 160
      implicitHeight: 36
    }
    onClicked: {
      // TODO: Implement add device functionality
    }
  }
}