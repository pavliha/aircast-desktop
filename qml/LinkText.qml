import QtQuick

Text {
  id: root
  color: mouseArea.containsMouse ? "#94A3B8" : "#FFFFFF"
  font.pixelSize: 12
  font.underline: true

  property alias hoverable: mouseArea.enabled
    signal clicked()

    MouseArea {
      id: mouseArea
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true
      onClicked: root.clicked()
    }
  }