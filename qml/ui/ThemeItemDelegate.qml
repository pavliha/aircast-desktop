// qml/components/ThemeItemDelegate.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

ItemDelegate {
    id: control
    width: parent.width
    height: 40
    property bool isSelected: false
    property string themeName: ""

    // Signal to notify that a theme was selected.
    signal themeSelected(string theme)

    // Add a MouseArea that extends beyond the delegate’s bounds
    MouseArea {
        id: extendedArea
        anchors.fill: parent
        // Extend the hit area by 4 pixels on each side.
        anchors.margins: -4
        hoverEnabled: true
        onClicked: {
            // Emit our custom signal with the theme name.
            themeSelected(control.themeName);
        }
        onEntered: control.hovered = true
        onExited: control.hovered = false
    }

    background: Rectangle {
        anchors.fill: parent
        color: {
            if (isSelected)
                return Theme.accent;
            if (control.hovered)
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

    // Wrap the content in a container with extra padding.
    contentItem: RowLayout {
        anchors.fill: parent
        anchors.margins: 4  // internal padding for a more generous hover area
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
