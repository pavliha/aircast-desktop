// DropdownMenuSeparator.qml
import QtQuick 2.15
import AircastDesktop 1.0

Rectangle {
    id: root
    
    color: Theme.border
    height: 1
    width: parent.width
    
    // Add spacing around the separator
    topMargin: Theme.spacing.xs
    bottomMargin: Theme.spacing.xs
}
