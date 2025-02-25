// qml/ui/menu/MenuProfile.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

ItemDelegate {
    id: root
    
    // Custom properties
    property string userName: ""
    property string userEmail: ""
    property int menuRadius: 8
    property bool positionFirst: false
    property bool positionLast: false
    
    width: parent ? parent.width : 280
    height: 90
    
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
        spacing: 16
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.topMargin: 12
        anchors.bottomMargin: 12
        
        Rectangle {
            width: 44
            height: 44
            radius: 22
            color: Theme.accent
            
            Label {
                anchors.centerIn: parent
                text: root.userName ? root.userName.charAt(0) : ""
                color: Theme.accentForeground
                font.pixelSize: 16
                font.weight: Font.Medium
            }
        }
        
        ColumnLayout {
            spacing: 6
            Layout.fillWidth: true
            
            Label {
                text: root.userName
                color: root.hovered || root.visualFocus || root.pressed ? 
                      Theme.accentForeground : Theme.foreground
                font.pixelSize: 14
                font.weight: Font.Medium
            }
            
            Label {
                text: root.userEmail
                color: root.hovered || root.visualFocus || root.pressed ? 
                      Qt.rgba(Theme.accentForeground.r, Theme.accentForeground.g, Theme.accentForeground.b, 0.8) : 
                      Theme.mutedForeground
                font.pixelSize: 14
            }
        }
    }
}