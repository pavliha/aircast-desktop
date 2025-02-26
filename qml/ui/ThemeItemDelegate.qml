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
    
    background: Rectangle {
        color: {
            if (isSelected) return Theme.accent
            if (control.hovered) return Theme.withAlpha(Theme.accent, 0.2)
            return "transparent"
        }
        radius: Theme.radius - 1
        
        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }
    
    contentItem: RowLayout {
        spacing: 12
        
        Icon {
            source: {
                if (themeName === "Light") return "qrc:/AircastDesktop/assets/icons/sun.svg"
                if (themeName === "Dark") return "qrc:/AircastDesktop/assets/icons/moon.svg"
                return "qrc:/AircastDesktop/assets/icons/monitor.svg"
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
                ColorAnimation { duration: 150 }
            }
        }
    }
}