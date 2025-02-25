// qml/ui/menu/MenuSeparator.qml
import QtQuick
import QtQuick.Controls
import AircastDesktop 1.0

MenuSeparator {
    id: root
    
    contentItem: Rectangle {
        implicitWidth: 280
        implicitHeight: 1
        color: Theme.border
    }
}