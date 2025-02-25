// qml/ui/menu/Menu.qml
import QtQuick
import QtQuick.Controls
import AircastDesktop 1.0

Menu {
    id: root
    
    property int menuRadius: 8
    property int shadowLayers: 3
    
    // Default dimensions
    width: 280
    
    // Add top and bottom margins
    topMargin: 8
    bottomMargin: 8
    
    // Modern shadow effect using multiple layers
    background: Item {
        implicitWidth: root.width
        
        Rectangle {
            id: menuBackground
            anchors.fill: parent
            color: Theme.popupBackground
            radius: root.menuRadius
            border.width: 1
            border.color: Theme.border
            clip: true // Add clipping to respect the rounded corners
        }
        
        // Create shadow effect with layered rectangles
        Repeater {
            model: root.shadowLayers
            Rectangle {
                anchors.fill: menuBackground
                anchors.margins: -(modelData + 1)
                radius: menuBackground.radius + (modelData + 1)
                color: "transparent"
                border.width: 1
                border.color: Theme.withAlpha(Theme.border, 0.1 / (modelData + 1))
                z: -1 - modelData
            }
        }
    }
}