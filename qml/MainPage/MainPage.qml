import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
  header: Header {}

  background: Rectangle {
    color: "#000000"
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 20
    spacing: 20

    TitleSection {}
    InfoBanner {}
    DeviceList {
      model: deviceManager.devices
    }
  }

  Component.onCompleted: deviceManager.fetchDevices()
}