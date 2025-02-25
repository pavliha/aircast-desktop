// qml/MainPage/UserMenuDropdown.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0
import "../ui/menu"

Button {
    id: root

    property string userName: "Pavlo Kostiuk"
    property string userEmail: "kostyk.pavel.09@gmail.com"
    
    // Padding from application edges
    property int edgePadding: 24

    variant: "ghost"

    contentItem: RowLayout {
        spacing: Theme.spacing.sm

        Label {
            text: userName
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

    // Using our custom Menu component
    Menu {
        id: menu
        width: 280
        
        // Profile component
        MenuProfile {
            userName: root.userName
            userEmail: root.userEmail
            positionFirst: true
            positionLast: false
        }
        
        // Custom separator
        MenuSeparator {}
        
        // Sign out button
        MenuButton {
            text: "Sign out"
            iconSource: "qrc:/AircastDesktop/assets/icons/log-out.svg"
            positionFirst: false
            positionLast: true
            
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