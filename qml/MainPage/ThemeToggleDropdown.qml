// ThemeToggleDropdown.qml
import QtQuick
import QtQuick.Controls as Controls
import Qt5Compat.GraphicalEffects
import AircastDesktop 1.0

Item {
    id: root

    implicitWidth: triggerButton.implicitWidth
    implicitHeight: triggerButton.implicitHeight

    property int edgePadding: 24

    // Trigger button
    Button {
        id: triggerButton
        anchors.fill: parent
        size: "icon"
        variant: "outline"

        contentItem: Icon {
            // The Icon updates automatically when themeChecker.themeMode changes.
            source: themeChecker.themeMode === "Light" ? "qrc:/AircastDesktop/assets/icons/sun.svg" : themeChecker.themeMode === "Dark" ? "qrc:/AircastDesktop/assets/icons/moon.svg" : "qrc:/AircastDesktop/assets/icons/monitor.svg"
            color: Theme.foreground
            width: 20
            height: 20
        }

        onClicked: {
            if (dropdownMenu.visible) {
                dropdownMenu.close();
            } else {
                positionAndOpenMenu();
            }
        }
    }

    // Dropdown menu
    Controls.Popup {
        id: dropdownMenu
        width: 180
        padding: 8
        closePolicy: Controls.Popup.CloseOnEscape | Controls.Popup.CloseOnPressOutside

        // Animations
        enter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: 150
                easing.type: Easing.OutQuad
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
                duration: 100
                easing.type: Easing.InQuad
            }
        }

        background: Rectangle {
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

            Repeater {
                model: ["Light", "Dark", "System"]
                delegate: ThemeItemDelegate {
                    required property string modelData
                    required property int index

                    themeName: modelData
                    isSelected: themeChecker.themeMode === modelData

                    onClicked: {
                        themeChecker.setThemeMode(modelData);
                        dropdownMenu.close();
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
