
// DropdownMenuContent.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import AircastDesktop 1.0

Rectangle {
    id: root
    
    color: Theme.card
    implicitWidth: content.width + Theme.spacing.md * 2
    implicitHeight: content.height + Theme.spacing.md * 2
    
    default property alias content: content.children
    
    Column {
        id: content
        anchors.centerIn: parent
        spacing: Theme.spacing.xs
        width: parent.width - Theme.spacing.md * 2
    }
}
