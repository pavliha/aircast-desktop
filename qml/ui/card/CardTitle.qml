// CardTitle
import QtQuick 2.15
import AircastDesktop 1.0

Text {
    id: root
    color: Theme.cardForeground
    font.pixelSize: 24      // Matches "text-2xl" in TSX
    font.weight: Font.DemiBold  // Adjust weight to match TSX "font-semibold"
    lineHeight: 1.0         // "leading-none" effect
    elide: Text.ElideRight
}
