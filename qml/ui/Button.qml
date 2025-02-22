// Button.qml
import QtQuick
import myproject 1.0

Rectangle {
    id: root

    // Public properties
    property string text: ""
    property bool disabled: false
    property string variant: "default"  // default, destructive, outline, secondary, ghost, link
    property string size: "default"     // default, sm, lg, icon
    property Component contentItem: defaultContent
    signal clicked

    // Private properties
    property bool hovered: false
    property bool pressed: false

    // Size configurations
    property var sizeConfigs: ({
            "default": {
                height: 36,
                padding: 16,
                fontSize: 14
            },
            "sm": {
                height: 32,
                padding: 12,
                fontSize: 12
            },
            "lg": {
                height: 40,
                padding: 32,
                fontSize: 14
            },
            "icon": {
                height: 36,
                width: 36,
                padding: 8
            }
        })

    // Variant configurations
    property var variantConfigs: ({
            "default": {
                background: Theme.primary,
                textColor: Theme.primaryForeground,
                hoverBackground: Theme.primary
            },
            "destructive": {
                background: Theme.destructive,
                textColor: Theme.destructiveForeground,
                hoverBackground: Theme.destructive
            },
            "outline": {
                background: Theme.background,
                textColor: Theme.foreground,
                borderColor: Theme.input,
                hoverBackground: Theme.accent,
                hoverTextColor: Theme.accentForeground
            },
            "secondary": {
                background: Theme.secondary,
                textColor: Theme.secondaryForeground,
                hoverBackground: Theme.secondary
            },
            "ghost": {
                background: "transparent",
                textColor: Theme.foreground,
                hoverBackground: Theme.accent,
                hoverTextColor: Theme.accentForeground
            },
            "link": {
                background: "transparent",
                textColor: Theme.primary,
                textDecoration: Text.Underline,
                textUnderlineOffset: 4
            }
        })

    // Component setup
    implicitWidth: size === "icon" ? sizeConfigs[size].width : Math.max(sizeConfigs[size].height * 2, contentLoader.implicitWidth + sizeConfigs[size].padding * 2)
    implicitHeight: sizeConfigs[size].height
    radius: Theme.radius

    // Dynamic properties based on variant and state
    color: {
        let baseColor = variantConfigs[variant].background;
        if (baseColor === "transparent")
            return baseColor;

        if (disabled) {
            return Theme.withAlpha(baseColor, 0.5);
        }
        if (hovered) {
            let hoverColor = variantConfigs[variant].hoverBackground;
            return Theme.withAlpha(hoverColor, 0.9);
        }
        return baseColor;
    }

    border.width: variant === "outline" ? 1 : 0
    border.color: variant === "outline" ? Theme.input : "transparent"

    // Focus ring
    Rectangle {
        id: focusRing
        anchors.fill: parent
        anchors.margins: -2
        radius: parent.radius + 2
        color: "transparent"
        border.width: root.activeFocus ? 1 : 0
        border.color: Theme.ring
        visible: root.activeFocus
    }

    // Content loader
    Loader {
        id: contentLoader
        anchors.centerIn: parent
        sourceComponent: root.contentItem
    }

    // Default content component
    Component {
        id: defaultContent
        Text {
            text: root.text
            font.pixelSize: sizeConfigs[root.size].fontSize
            font.weight: Font.Medium
            color: {
                let textColor = variantConfigs[root.variant].textColor;
                if (root.disabled) {
                    return Theme.withAlpha(textColor, 0.5);
                }
                if (root.hovered && variantConfigs[root.variant].hoverTextColor) {
                    return variantConfigs[root.variant].hoverTextColor;
                }
                return textColor;
            }
            textFormat: Text.RichText
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // Mouse area for handling interactions
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onEntered: if (!root.disabled)
            root.hovered = true
        onExited: root.hovered = false
        onPressed: if (!root.disabled)
            root.pressed = true
        onReleased: root.pressed = false
        onClicked: if (!root.disabled)
            root.clicked()
    }

    // Keyboard handling
    Keys.onPressed: event => {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
            if (!root.disabled) {
                root.pressed = true;
                root.clicked();
            }
            event.accepted = true;
        }
    }
    Keys.onReleased: event => {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
            root.pressed = false;
            event.accepted = true;
        }
    }

    // Focus handling
    activeFocusOnTab: !disabled
}
