// DropdownMenuItem.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import AircastDesktop 1.0

Rectangle {
    id: root
    
    property bool inset: false
    property bool disabled: false
    property string text: ""
    property string shortcut: ""
    property Component icon: null
    property bool checkable: false
    property bool checked: false
    signal clicked
    
    color: "transparent"
    width: parent.width
    height: row.height + Theme.spacing.sm * 1.5
    radius: Theme.radius / 2
    
    opacity: disabled ? 0.5 : 1.0
    
    RowLayout {
        id: row
        width: parent.width
        spacing: Theme.spacing.sm
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: inset ? Theme.spacing.md * 2 : Theme.spacing.sm
        anchors.rightMargin: Theme.spacing.sm
        
        // Icon or check indicator
        Loader {
            id: iconLoader
            sourceComponent: {
                if (root.checkable) {
                    return checkComponent;
                } else if (root.icon) {
                    return root.icon;
                } else {
                    return null;
                }
            }
            visible: sourceComponent !== null
            Layout.preferredWidth: 16
            Layout.preferredHeight: 16
        }
        
        // Text label
        Text {
            text: root.text
            font.pixelSize: 14
            color: Theme.foreground
            Layout.fillWidth: true
            elide: Text.ElideRight
        }
        
        // Shortcut
        Text {
            visible: root.shortcut !== ""
            text: root.shortcut
            font.pixelSize: 12
            color: Theme.withAlpha(Theme.foreground, 0.6)
            Layout.alignment: Qt.AlignRight
        }
    }
    
    // Check indicator component
    Component {
        id: checkComponent
        
        Rectangle {
            width: 16
            height: 16
            radius: 2
            color: "transparent"
            border.width: 1
            border.color: root.checked ? Theme.primary : Theme.border
            
            Rectangle {
                anchors.fill: parent
                anchors.margins: 3
                radius: 1
                color: Theme.primary
                visible: root.checked
            }
        }
    }
    
    MouseArea {
        anchors.fill: parent
        enabled: !root.disabled
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        
        onClicked: {
            if (root.checkable) {
                root.checked = !root.checked;
            }
            root.clicked();
        }
        
        onEntered: root.color = Theme.accent
        onExited: root.color = "transparent"
    }
}