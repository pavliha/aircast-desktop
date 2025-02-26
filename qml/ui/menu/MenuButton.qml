// qml/ui/menu/MenuButton.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

MenuItem {
    id: root
    
    // Custom properties
    property url iconSource: ""
    property int menuRadius: 8
    property bool positionFirst: false
    property bool positionLast: false
    
    implicitHeight: 48
    
    background: Rectangle {
        color: "transparent"
        
        // Custom highlight that respects borders
        Rectangle {
            visible: root.hovered || root.visualFocus || root.pressed
            anchors.fill: parent
            anchors.leftMargin: 1
            anchors.rightMargin: 1
            anchors.topMargin: root.positionFirst ? 1 : 0
            anchors.bottomMargin: root.positionLast ? 1 : 0
            radius: root.menuRadius - 1
            color: Theme.accent
            
            // If not first, extend top to remove radius
            Rectangle {
                visible: !root.positionFirst && parent.visible
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                height: parent.radius
                color: parent.color
            }
            
            // If not last, extend bottom to remove radius
            Rectangle {
                visible: !root.positionLast && parent.visible
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: parent.radius
                color: parent.color
            }
        }
    }
    
    contentItem: RowLayout {
        spacing: 8
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        
        Icon {
            visible: root.iconSource != ""
            source: root.iconSource
            color: root.hovered || root.visualFocus || root.pressed ? 
                  Theme.accentForeground : Theme.foreground
            width: 16
            height: 16
        }
        
        Label {
            text: root.text
            color: root.hovered || root.visualFocus || root.pressed ? 
                  Theme.accentForeground : Theme.foreground
            font.pixelSize: 14
            Layout.fillWidth: true
            verticalAlignment: Text.AlignVCenter
        }
    }
}