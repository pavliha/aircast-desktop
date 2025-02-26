// DropdownMenuLabel.qml
import QtQuick 2.15
import AircastDesktop 1.0

Text {
    id: root
    
    property bool inset: false
    
    color: Theme.mutedForeground
    font.pixelSize: 14
    font.weight: Font.DemiBold
    leftPadding: inset ? Theme.spacing.md * 2 : Theme.spacing.sm
    rightPadding: Theme.spacing.sm
    topPadding: Theme.spacing.xs
    bottomPadding: Theme.spacing.xs
    width: parent.width
}