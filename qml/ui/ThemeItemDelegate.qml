// qml/components/ThemeItemDelegate.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

ItemDelegate {
    id: control
    width: parent.width
    height: 40
    clip: true                     // Ensure children (like the MouseArea) don’t render outside the delegate.
    property bool isSelected: false
    property string themeName: ""

    // Bind a property directly to the MouseArea’s containsMouse.
    property bool customHovered: extendedArea.containsMouse

    signal themeSelected(string theme)

    MouseArea {
        id: extendedArea
        // Anchor to all sides
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        // Extend horizontally only:
        anchors.leftMargin: -4
        anchors.rightMargin: -4
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        hoverEnabled: true
        onClicked: {
            themeSelected(control.themeName);
        }
    }

    background: Rectangle {
        anchors.fill: parent
        color: {
            if (isSelected)
                return Theme.accent;
            if (control.customHovered)
                return Theme.withAlpha(Theme.accent, 0.2);
            return "transparent";
        }
        radius: Theme.radius - 1
        Behavior on color {
            ColorAnimation {
                duration: 150
            }
        }
    }

    contentItem: RowLayout {
        anchors.fill: parent
        anchors.margins: 4  // Internal padding
        spacing: 12

        Icon {
            source: {
                if (themeName === "Light")
                    return "qrc:/AircastDesktop/assets/icons/sun.svg";
                if (themeName === "Dark")
                    return "qrc:/AircastDesktop/assets/icons/moon.svg";
                return "qrc:/AircastDesktop/assets/icons/monitor.svg";
            }
            color: isSelected ? Theme.accentForeground : Theme.foreground
            size: 16
        }

        Label {
            text: themeName
            color: isSelected ? Theme.accentForeground : Theme.foreground
            font.pixelSize: 14
            Layout.fillWidth: true
            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }
        }
    }
}
