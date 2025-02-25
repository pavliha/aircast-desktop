// qml/ui/menu/MenuItem.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

MenuItem {
    id: root
    
    // Custom properties
    property int menuRadius: 8
    property bool positionFirst: false
    property bool positionLast: false
    
    // Default styling
    implicitHeight: 40
    
    background: Rectangle {
        id: itemBackground
        color: "transparent"
        
        // Highlight overlay with proper radius handling
        Rectangle {
            id: highlightRect
            visible: root.hovered || root.visualFocus || root.pressed
            anchors.fill: parent
            anchors.leftMargin: 1
            anchors.rightMargin: 1
            
            color: Theme.accent
            
            // Set radius based on position
            radius: menuRadius - 1 // Slightly smaller than menu radius
            
            // If this is not the first item, remove top radius
            Rectangle {
                visible: !root.positionFirst && highlightRect.visible
                anchors.top: parent.top
                width: parent.width
                height: parent.radius
                color: parent.color
            }
            
            // If this is not the last item, remove bottom radius
            Rectangle {
                visible: !root.positionLast && highlightRect.visible
                anchors.bottom: parent.bottom
                width: parent.width
                height: parent.radius
                color: parent.color
            }
        }
    }
    
    // Default content style
    contentItem: Label {
        text: root.text
        color: root.hovered || root.visualFocus || root.pressed ? 
               Theme.accentForeground : Theme.foreground
        font.pixelSize: 14
        verticalAlignment: Text.AlignVCenter
        leftPadding: 20
    }
}