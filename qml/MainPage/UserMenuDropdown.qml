// qml/MainPage/UserMenuDropdown.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

Item {
    id: root
    
    // Properties
    property string userName: "Pavlo Kostiuk"
    property string userEmail: "kostyk.pavel.09@gmail.com"
    property int edgePadding: 24
    
    implicitWidth: triggerButton.implicitWidth
    implicitHeight: triggerButton.implicitHeight
    
    // Trigger button
    Button {
        id: triggerButton
        anchors.fill: parent
        variant: "ghost"
        
        contentItem: RowLayout {
            spacing: Theme.spacing.sm
            
            Label {
                text: root.userName
                color: Theme.foreground
                font.weight: Font.Medium
                font.pixelSize: 14
            }
            
            Icon {
                source: "qrc:/AircastDesktop/assets/icons/circle-user.svg"
                color: Theme.foreground
                width: 24
                height: 24
            }
        }
        
        onClicked: {
            if (dropdownMenu.visible) {
                dropdownMenu.close()
            } else {
                positionAndOpenMenu()
            }
        }
    }
    
    // Dropdown menu
    Popup {
        id: dropdownMenu
        width: 280
        padding: 0
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        
        // Animations
        enter: Transition {
            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 150; easing.type: Easing.OutQuad }
        }
        
        exit: Transition {
            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 100; easing.type: Easing.InQuad }
        }
        
        background: Rectangle {
            id: menuBackground
            color: Theme.card
            border.color: Theme.border
            border.width: 1
            radius: Theme.radius
            
            // Add shadow
            layer.enabled: true
            layer.effect: DropShadow {
                horizontalOffset: 0
                verticalOffset: 4
                radius: 8.0
                samples: 17
                color: Theme.withAlpha(Theme.shadow, 0.15)
            }
        }
        
        contentItem: Column {
            width: parent.width
            spacing: 0
            
            // Profile component
            Item {
                width: parent.width
                height: 80
                
                // Main background
                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    
                    // Highlight effect that respects border radius on top
                    Rectangle {
                        id: profileHighlightRect
                        anchors.fill: parent
                        anchors.margins: 1  // To avoid overlap with parent border
                        anchors.bottomMargin: 0 // No margin on bottom since it's not the last item
                        radius: Theme.radius - 1
                        color: Theme.accent
                        visible: false
                        
                        // We need to cut off the bottom radius since this isn't the last item
                        Rectangle {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            height: parent.radius
                            color: parent.color
                        }
                    }
                }
                
                // Make profile area interactive
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    
                    onEntered: profileHighlightRect.visible = true
                    onExited: profileHighlightRect.visible = false
                }
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 12
                    
                    // Avatar - using P instead of first character
                    Rectangle {
                        width: 48
                        height: 48
                        radius: 24
                        color: Theme.accent
                        
                        Label {
                            anchors.centerIn: parent
                            text: "P" // Using P as in the screenshot
                            color: Theme.accentForeground
                            font.pixelSize: 18
                            font.weight: Font.Medium
                        }
                    }
                    
                    // User info
                    Column {
                        Layout.fillWidth: true
                        spacing: 4
                        
                        Label {
                            text: root.userName
                            color: profileHighlightRect.visible ? Theme.accentForeground : Theme.foreground
                            font.pixelSize: 16
                            font.weight: Font.Medium
                        }
                        
                        Label {
                            text: root.userEmail
                            color: profileHighlightRect.visible ? 
                                  Theme.withAlpha(Theme.accentForeground, 0.8) : Theme.mutedForeground
                            font.pixelSize: 14
                        }
                    }
                }
            }
            
            // Separator
            Rectangle {
                width: parent.width
                height: 1
                color: Theme.border
            }
            
            // Sign out button
            Item {
                width: parent.width
                height: 48
                
                // Main background remains transparent
                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    
                    // Highlight effect that respects border radius on bottom
                    Rectangle {
                        id: highlightRect
                        anchors.fill: parent
                        anchors.margins: 1  // To avoid overlap with parent border
                        anchors.topMargin: 0 // No margin on top since it's not the first item
                        radius: Theme.radius - 1
                        color: Theme.accent
                        visible: false
                        
                        // We need to cut off the top radius since this isn't the first item
                        Rectangle {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            height: parent.radius
                            color: parent.color
                        }
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    
                    onEntered: highlightRect.visible = true
                    onExited: highlightRect.visible = false
                    
                    onClicked: {
                        dropdownMenu.close()
                        console.log("Sign out clicked")
                        // Handle sign out logic here
                    }
                }
                
                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 16
                    anchors.rightMargin: 16
                    spacing: 12
                    
                    Icon {
                        source: "qrc:/AircastDesktop/assets/icons/log-out.svg"
                        color: highlightRect.visible ? Theme.accentForeground : Theme.foreground
                        width: 16
                        height: 16
                    }
                    
                    Label {
                        text: "Sign out"
                        color: highlightRect.visible ? Theme.accentForeground : Theme.foreground
                        font.pixelSize: 14
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
    
    // Function to position and open the menu
    function positionAndOpenMenu() {
        // Find the application window
        var appWindow = Window.window;
        
        // Calculate base position (centered under the button)
        var menuX = (root.width - dropdownMenu.width) / 2;
        var menuY = root.height + 8;
        
        // Get the button's position in global coordinates
        var buttonGlobalPos = root.mapToItem(null, 0, 0);
        
        // Check if the menu would go off the right edge
        if (buttonGlobalPos.x + menuX + dropdownMenu.width > appWindow.width - edgePadding) {
            // Adjust menuX to keep within edgePadding from right edge
            menuX = Math.min(menuX, appWindow.width - buttonGlobalPos.x - dropdownMenu.width - edgePadding);
        }
        
        // Check if the menu would go off the left edge
        if (buttonGlobalPos.x + menuX < edgePadding) {
            // Adjust menuX to keep within edgePadding from left edge
            menuX = edgePadding - buttonGlobalPos.x;
        }
        
        // Position and open the menu
        dropdownMenu.x = menuX;
        dropdownMenu.y = menuY;
        dropdownMenu.open();
    }
}