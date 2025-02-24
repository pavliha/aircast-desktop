// UserMenuDropdown.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

Button {
    id: root

    property string userName: "Pavlo Kostiuk"
    property string userEmail: "kostyk.pavel.09@gmail.com"
    
    // Padding from application edges
    property int edgePadding: 16

    variant: "ghost"

    contentItem: RowLayout {
        spacing: Theme.spacing.sm

        Label {
            text: userName
            color: Theme.foreground
            font.weight: Font.Medium
            font.pixelSize: 14
        }

        TintedIcon {
            source: "qrc:/AircastDesktop/assets/icons/circle-user.svg"
            tintColor: Theme.foreground
            width: 24
            height: 24
        }
    }

    // Using a Menu instead of a Popup
    Menu {
        id: menu
        width: 280
        
        // Add top and bottom margins
        topMargin: 8
        bottomMargin: 8
        
        // Custom style for menu items
        delegate: MenuItem {
            id: menuItem
            implicitHeight: 40
            
            background: Rectangle {
                color: menuItem.highlighted ? Theme.accent : "transparent"
            }
            
            contentItem: Label {
                text: menuItem.text
                color: menuItem.highlighted ? Theme.accentForeground : Theme.foreground
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
            }
        }
        
        // Modern shadow effect using multiple layers
        background: Item {
            implicitWidth: 280
            
            Rectangle {
                id: menuBackground
                anchors.fill: parent
                color: Theme.popupBackground
                radius: 8
                border.width: 1
                border.color: Theme.border
            }
            
            // Create shadow effect with layered rectangles
            Repeater {
                model: 3
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
        
        // Profile Section
        ItemDelegate {
            id: profileSection
            width: parent ? parent.width : 280
            height: 90
            
            background: Rectangle {
                color: "transparent"
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
                        text: userName.charAt(0)
                        color: Theme.accentForeground
                        font.pixelSize: 16
                        font.weight: Font.Medium
                    }
                }
                
                ColumnLayout {
                    spacing: 6
                    Layout.fillWidth: true
                    
                    Label {
                        text: userName
                        color: Theme.foreground
                        font.pixelSize: 14
                        font.weight: Font.Medium
                    }
                    
                    Label {
                        text: userEmail
                        color: Theme.mutedForeground
                        font.pixelSize: 14
                    }
                }
            }
        }
        
        MenuSeparator {
            contentItem: Rectangle {
                implicitWidth: 280
                implicitHeight: 1
                color: Theme.border
            }
        }
        
        // Sign Out action
        MenuItem {
            id: signOutItem
            text: "Sign out"
            height: 50
            
            contentItem: RowLayout {
                spacing: 12
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                
                TintedIcon {
                    source: "qrc:/AircastDesktop/assets/icons/log-out.svg"
                    tintColor: signOutItem.highlighted ? Theme.accentForeground : Theme.foreground
                    width: 18
                    height: 18
                }
                
                Label {
                    text: "Sign out"
                    color: signOutItem.highlighted ? Theme.accentForeground : Theme.foreground
                    font.pixelSize: 14
                    Layout.fillWidth: true
                }
            }
            
            onTriggered: {
                // Handle sign out action here
                console.log("Sign out clicked")
            }
        }
    }
    
    onClicked: {
        console.log("Button clicked, opening menu");
        
        // Find the application window
        var appWindow = Window.window;
        
        // Calculate menu position
        var menuX = Math.max(0, (root.width - menu.width) / 2);
        var menuY = root.height + 12;
        
        // Get the button's position in item coordinates
        var buttonGlobalX = root.mapToItem(null, 0, 0).x;
        
        // Check if the menu would go off the right edge
        if (buttonGlobalX + menuX + menu.width > appWindow.width - edgePadding) {
            // Adjust menuX to keep edgePadding from right edge
            menuX = Math.min(menuX, appWindow.width - buttonGlobalX - menu.width - edgePadding);
        }
        
        // Check if the menu would go off the left edge
        if (buttonGlobalX + menuX < edgePadding) {
            // Adjust menuX to keep edgePadding from left edge
            menuX = edgePadding - buttonGlobalX;
        }
        
        console.log("Menu position:", menuX, menuY);
        console.log("Button global X:", buttonGlobalX);
        console.log("Window width:", appWindow.width);
        
        // Show the menu
        menu.popup(menuX, menuY);
    }
}