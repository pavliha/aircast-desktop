// DropdownMenu.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import AircastDesktop 1.0

// Assuming Theme is imported as a singleton named "Theme"

Item {
    id: root
    
    // Public properties
    property var model: []  // Array of menu items
    property Item triggerItem: null  // Item that triggers the menu
    property int minWidth: 200
    
    // Events
    signal itemClicked(int index, var item)
    
    // Private properties
    property bool _isOpen: false
    
    width: triggerItem ? triggerItem.width : 0
    height: triggerItem ? triggerItem.height : 0
    visible: triggerItem != null
    
    // Trigger area (attach to the provided trigger item)
    MouseArea {
        id: triggerArea
        anchors.fill: parent
        enabled: triggerItem != null
        
        onClicked: {
            if (_isOpen) {
                closeMenu()
            } else {
                openMenu()
            }
        }
    }
    
    // Menu popup
    Popup {
        id: menuPopup
        
        width: Math.max(root.minWidth, contentColumn.implicitWidth + (Theme.spacing.md * 2))
        padding: Theme.spacing.xs
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        
        onClosed: {
            root._isOpen = false
        }
        
        background: Rectangle {
            color: Theme.card
            border.color: Theme.border
            border.width: 1
            radius: Theme.radius
            
            // Shadow
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 0
                verticalOffset: 2
                radius: 8.0
                samples: 17
                color: Theme.shadow
            }
        }
        
        contentItem: ColumnLayout {
            id: contentColumn
            spacing: 1
            
            Repeater {
                model: root.model
                
                delegate: Component {
                    id: menuItemDelegate
                    
                    Loader {
                        id: itemLoader
                        Layout.fillWidth: true
                        sourceComponent: {
                            if (modelData.type === "separator") {
                                return separatorComponent
                            } else if (modelData.type === "checkbox") {
                                return checkboxComponent
                            } else if (modelData.type === "radio") {
                                return radioComponent
                            } else if (modelData.type === "label") {
                                return labelComponent
                            } else if (modelData.type === "sub") {
                                return subMenuComponent
                            } else {
                                return menuItemComponent
                            }
                        }
                        
                        property var itemData: modelData
                        property int itemIndex: index
                    }
                }
            }
        }
    }
    
    // Regular menu item component
    Component {
        id: menuItemComponent
        
        Rectangle {
            id: menuItem
            width: parent.width
            height: 32
            color: mouseArea.containsMouse ? Theme.accent : "transparent"
            radius: Theme.radius / 2
            
            property bool inset: itemData.inset === true
            
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: inset ? 32 : Theme.spacing.md
                anchors.rightMargin: Theme.spacing.md
                spacing: Theme.spacing.xs
                
                // Optional icon
                Item {
                    Layout.preferredWidth: 16
                    Layout.preferredHeight: 16
                    Layout.alignment: Qt.AlignVCenter
                    visible: itemData.icon !== undefined
                    
                    // Replace with your icon implementation
                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                        visible: itemData.icon !== undefined
                        
                        // This should be replaced with your actual icon component
                        // For example: Icon { source: itemData.icon }
                    }
                }
                
                // Text
                Text {
                    Layout.fillWidth: true
                    text: itemData.text || ""
                    color: mouseArea.containsMouse ? Theme.accentForeground : Theme.cardForeground
                    font.pixelSize: 14
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }
                
                // Optional shortcut
                Text {
                    text: itemData.shortcut || ""
                    visible: itemData.shortcut !== undefined
                    color: mouseArea.containsMouse ? Theme.accentForeground : Theme.mutedForeground
                    opacity: 0.8
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignRight
                }
            }
            
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                enabled: !itemData.disabled
                
                onClicked: {
                    root.itemClicked(itemIndex, itemData)
                    if (!itemData.keepOpen) {
                        closeMenu()
                    }
                }
            }
            
            // Disabled state
            opacity: itemData.disabled ? 0.5 : 1.0
        }
    }
    
    // Separator component
    Component {
        id: separatorComponent
        
        Rectangle {
            width: parent.width
            height: 1
            color: Theme.border
            opacity: 0.7
            Layout.topMargin: Theme.spacing.xs / 2
            Layout.bottomMargin: Theme.spacing.xs / 2
            Layout.leftMargin: Theme.spacing.xs
            Layout.rightMargin: Theme.spacing.xs
        }
    }
    
    // Checkbox item component
    Component {
        id: checkboxComponent
        
        Rectangle {
            id: checkboxItem
            width: parent.width
            height: 32
            color: mouseArea.containsMouse ? Theme.accent : "transparent"
            radius: Theme.radius / 2
            
            property bool checked: itemData.checked === true
            
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: Theme.spacing.md
                anchors.rightMargin: Theme.spacing.md
                spacing: Theme.spacing.xs
                
                // Checkbox indicator
                Rectangle {
                    Layout.preferredWidth: 16
                    Layout.preferredHeight: 16
                    Layout.alignment: Qt.AlignVCenter
                    Layout.leftMargin: 6
                    border.color: checked ? Theme.primary : Theme.border
                    border.width: 1
                    radius: 2
                    color: checked ? Theme.primary : "transparent"
                    
                    // Checkmark
                    Text {
                        anchors.centerIn: parent
                        text: "✓"
                        color: Theme.primaryForeground
                        font.pixelSize: 12
                        visible: checked
                    }
                }
                
                // Text
                Text {
                    Layout.fillWidth: true
                    text: itemData.text || ""
                    color: mouseArea.containsMouse ? Theme.accentForeground : Theme.cardForeground
                    font.pixelSize: 14
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }
            }
            
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                enabled: !itemData.disabled
                
                onClicked: {
                    // Toggle checkbox state
                    itemData.checked = !checked
                    root.itemClicked(itemIndex, itemData)
                }
            }
            
            // Disabled state
            opacity: itemData.disabled ? 0.5 : 1.0
        }
    }
    
    // Radio item component
    Component {
        id: radioComponent
        
        Rectangle {
            id: radioItem
            width: parent.width
            height: 32
            color: mouseArea.containsMouse ? Theme.accent : "transparent"
            radius: Theme.radius / 2
            
            property bool checked: itemData.checked === true
            
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: Theme.spacing.md
                anchors.rightMargin: Theme.spacing.md
                spacing: Theme.spacing.xs
                
                // Radio indicator
                Rectangle {
                    Layout.preferredWidth: 14
                    Layout.preferredHeight: 14
                    Layout.alignment: Qt.AlignVCenter
                    Layout.leftMargin: 6
                    border.color: checked ? Theme.primary : Theme.border
                    border.width: 1
                    radius: 7
                    color: "transparent"
                    
                    // Radio dot
                    Rectangle {
                        anchors.centerIn: parent
                        width: 6
                        height: 6
                        radius: 3
                        color: Theme.primary
                        visible: checked
                    }
                }
                
                // Text
                Text {
                    Layout.fillWidth: true
                    text: itemData.text || ""
                    color: mouseArea.containsMouse ? Theme.accentForeground : Theme.cardForeground
                    font.pixelSize: 14
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }
            }
            
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                enabled: !itemData.disabled
                
                onClicked: {
                    // Set this radio as checked and uncheck others in the group
                    if (itemData.group) {
                        for (let i = 0; i < root.model.length; i++) {
                            if (root.model[i].group === itemData.group) {
                                root.model[i].checked = (i === itemIndex)
                            }
                        }
                    } else {
                        itemData.checked = true
                    }
                    root.itemClicked(itemIndex, itemData)
                }
            }
            
            // Disabled state
            opacity: itemData.disabled ? 0.5 : 1.0
        }
    }
    
    // Label component
    Component {
        id: labelComponent
        
        Item {
            width: parent.width
            height: textItem.implicitHeight + Theme.spacing.md
            
            property bool inset: itemData.inset === true
            
            Text {
                id: textItem
                anchors.fill: parent
                anchors.leftMargin: inset ? 32 : Theme.spacing.md
                anchors.rightMargin: Theme.spacing.md
                text: itemData.text || ""
                color: Theme.mutedForeground
                font.pixelSize: 14
                font.bold: true
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
    
    // Sub-menu component - simplified version
    Component {
        id: subMenuComponent
        
        Rectangle {
            id: subMenuItem
            width: parent.width
            height: 32
            color: mouseArea.containsMouse ? Theme.accent : "transparent"
            radius: Theme.radius / 2
            
            property bool inset: itemData.inset === true
            
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: inset ? 32 : Theme.spacing.md
                anchors.rightMargin: Theme.spacing.md
                spacing: Theme.spacing.xs
                
                // Optional icon
                Item {
                    Layout.preferredWidth: 16
                    Layout.preferredHeight: 16
                    Layout.alignment: Qt.AlignVCenter
                    visible: itemData.icon !== undefined
                    
                    // Replace with your icon implementation
                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                        visible: itemData.icon !== undefined
                    }
                }
                
                // Text
                Text {
                    Layout.fillWidth: true
                    text: itemData.text || ""
                    color: mouseArea.containsMouse ? Theme.accentForeground : Theme.cardForeground
                    font.pixelSize: 14
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }
                
                // Chevron right icon
                Text {
                    text: "›"
                    color: mouseArea.containsMouse ? Theme.accentForeground : Theme.cardForeground
                    font.pixelSize: 16
                    font.bold: true
                }
            }
            
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                enabled: !itemData.disabled
                
                onClicked: {
                    // In a full implementation, this would open a sub-menu
                    root.itemClicked(itemIndex, itemData)
                }
            }
            
            // Disabled state
            opacity: itemData.disabled ? 0.5 : 1.0
        }
    }
    
    // Function to open the menu
    function openMenu() {
        if (triggerItem) {
            // Position menu relative to trigger item
            menuPopup.x = 0
            menuPopup.y = triggerItem.height
            
            menuPopup.open()
            root._isOpen = true
        }
    }
    
    // Function to close the menu
    function closeMenu() {
        menuPopup.close()
        root._isOpen = false
    }
}