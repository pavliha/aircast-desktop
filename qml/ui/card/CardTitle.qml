// CardTitle
import QtQuick 2.15
import myproject 1.0

Text {
    id: root
    color: "red"
    font.pixelSize: 24      // Matches "text-2xl" in TSX
    font.weight: Font.DemiBold  // Adjust weight to match TSX "font-semibold"
    lineHeight: 1.0         // "leading-none" effect
    horizontalAlignment: Text.AlignLeft
    elide: Text.ElideRight
}
