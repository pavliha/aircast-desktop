import QtQuick
import AircastDesktop 1.0

Text {
    id: root
    color: mouseArea.containsMouse ? Theme.mutedForeground : Theme.foreground
    font.pixelSize: 12
    font.underline: true

    property alias hoverable: mouseArea.enabled
    signal clicked

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: root.clicked()
    }
}
