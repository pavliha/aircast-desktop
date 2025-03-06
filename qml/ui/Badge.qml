// Badge.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

Rectangle {
    id: root

    // Properties
    property string text: ""
    property string variant: "default" // "default", "secondary", "destructive", "outline"
    property Item contentItem: defaultContent

    // Size properties
    implicitHeight: contentItem.implicitHeight + paddingSize * 2
    implicitWidth: contentItem.implicitWidth + paddingSize * 2

    // Use a property instead of padding
    property int paddingSize: Theme.spacing.xs / 2 // 4px (half of xs)

    // Style properties
    radius: height / 2 // Rounded-full
    border.width: variant === "outline" ? 1 : 0

    // Default content
    Row {
        id: defaultContent
        anchors.centerIn: parent

        Text {
            text: root.text
            font.pixelSize: 12
            font.weight: Font.Medium
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            leftPadding: Theme.spacing.xs * 1.25 // 10px
            rightPadding: Theme.spacing.xs * 1.25
            color: getTextColor()
        }
    }

    // Colors based on variant
    color: {
        switch (variant) {
        case "default":
            return Theme.primary;
        case "secondary":
            return Theme.secondary;
        case "destructive":
            return Theme.destructive;
        case "outline":
            return "transparent";
        default:
            return Theme.primary;
        }
    }

    border.color: variant === "outline" ? Theme.border : "transparent"

    // Helper function to get text color based on variant
    function getTextColor() {
        switch (variant) {
        case "default":
            return Theme.primaryForeground;
        case "secondary":
            return Theme.secondaryForeground;
        case "destructive":
            return Theme.destructiveForeground;
        case "outline":
            return Theme.foreground;
        default:
            return Theme.primaryForeground;
        }
    }

    // Hover effect
    Rectangle {
        id: hoverBackground
        anchors.fill: parent
        radius: parent.radius
        color: {
            switch (root.variant) {
            case "default":
                return Theme.withAlpha(Theme.primary, 0.8);
            case "secondary":
                return Theme.withAlpha(Theme.secondary, 0.8);
            case "destructive":
                return Theme.withAlpha(Theme.destructive, 0.8);
            case "outline":
                return Theme.withAlpha(Theme.foreground, 0.1);
            default:
                return Theme.withAlpha(Theme.primary, 0.8);
            }
        }
        visible: false
    }

    // Mouse area for hover effects
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: hoverBackground.visible = true
        onExited: hoverBackground.visible = false
        onClicked: root.clicked()
    }

    // Focus visual
    Rectangle {
        id: focusRing
        anchors.fill: parent
        anchors.margins: -2
        radius: parent.radius + 2
        color: "transparent"
        border.width: root.activeFocus ? 2 : 0
        border.color: Theme.ring
        visible: root.activeFocus
    }

    // Signal
    signal clicked

    // Transitions for hover effect
    Behavior on color {
        ColorAnimation {
            duration: 150
            easing.type: Easing.OutQuad
        }
    }
}
