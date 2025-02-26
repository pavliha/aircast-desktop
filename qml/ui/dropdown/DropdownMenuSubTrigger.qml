// DropdownMenuSubTrigger.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import AircastDesktop 1.0

Rectangle {
    id: root
    
    property bool inset: false
    property string text: ""
    
    color: "transparent"
    width: parent.width
    height: row.height + Theme.spacing.sm * 1.5
    radius: Theme.radius / 2
    
    RowLayout {
        id: row
        width: parent.width
        spacing: Theme.spacing.sm
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: inset ? Theme.spacing.md * 2 : Theme.spacing.sm
        anchors.rightMargin: Theme.spacing.sm
        
        // Text label
        Text {
            text: root.text
            font.pixelSize: 14
            color: Theme.foreground
            Layout.fillWidth: true
            elide: Text.ElideRight
        }
        
        // Chevron right indicator
        Text {
            text: "›"
            font.pixelSize: 16
            color: Theme.foreground
            Layout.alignment: Qt.AlignRight
        }
    }
    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        
        onEntered: root.color = Theme.accent
        onExited: root.color = "transparent"
    }
}
