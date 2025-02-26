// DropdownMenuSub.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import AircastDesktop 1.0

Item {
    id: root
    
    width: parent.width
    height: trigger.height
    
    property alias trigger: trigger.sourceComponent
    property alias content: subContent.sourceComponent
    
    Loader {
        id: trigger
        width: parent.width
        
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            
            onEntered: {
                subMenuPopup.open();
            }
        }
    }
    
    Popup {
        id: subMenuPopup
        x: parent.width
        y: 0
        padding: 0
        
        background: Rectangle {
            color: Theme.card
            border.color: Theme.border
            border.width: 1
            radius: Theme.radius
            
            layer.enabled: true
            layer.effect: DropShadow {
                horizontalOffset: 0
                verticalOffset: 4
                radius: 8.0
                samples: 17
                color: Theme.withAlpha(Theme.shadow, 0.15)
            }
        }
        
        Loader {
            id: subContent
            width: implicitWidth
            height: implicitHeight
        }
        
        onAboutToHide: {
            // Add a small delay to prevent flickering
            closeTimer.start();
        }
        
        Timer {
            id: closeTimer
            interval: 50
            onTriggered: subMenuPopup.close()
        }
    }
}