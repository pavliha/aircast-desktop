// DropdownMenu.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import AircastDesktop 1.0

Item {
    id: root
    
    property alias trigger: triggerLoader.sourceComponent
    property alias content: contentLoader.sourceComponent
    property bool open: false
    
    implicitWidth: triggerLoader.width
    implicitHeight: triggerLoader.height
    
    Loader {
        id: triggerLoader
        anchors.left: parent.left
        anchors.top: parent.top
        
        MouseArea {
            anchors.fill: parent
            onClicked: root.open = !root.open
            cursorShape: Qt.PointingHandCursor
        }
    }
    
    Popup {
        id: menuPopup
        y: triggerLoader.height + Theme.spacing.xs
        width: contentLoader.implicitWidth
        height: contentLoader.implicitHeight
        padding: 0
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        
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
        
        onVisibleChanged: {
            if (!visible) {
                root.open = false
            }
        }
        
        Loader {
            id: contentLoader
            width: parent.width
        }
    }
    
    states: [
        State {
            name: "open"
            when: root.open
            PropertyChanges {
                target: menuPopup
                visible: true
                opacity: 1.0
            }
        },
        State {
            name: "closed"
            when: !root.open
            PropertyChanges {
                target: menuPopup
                visible: false
                opacity: 0.0
            }
        }
    ]
    
    transitions: [
        Transition {
            from: "closed"
            to: "open"
            SequentialAnimation {
                PropertyAction {
                    target: menuPopup
                    property: "visible"
                    value: true
                }
                NumberAnimation {
                    target: menuPopup
                    property: "opacity"
                    duration: 150
                    easing.type: Easing.OutCubic
                }
                ScriptAction {
                    script: {
                        menuPopup.forceActiveFocus();
                    }
                }
            }
        },
        Transition {
            from: "open"
            to: "closed"
            SequentialAnimation {
                NumberAnimation {
                    target: menuPopup
                    property: "opacity"
                    duration: 100
                    easing.type: Easing.InCubic
                }
                PropertyAction {
                    target: menuPopup
                    property: "visible"
                    value: false
                }
            }
        }
    ]
}