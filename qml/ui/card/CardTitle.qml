import QtQuick
import QtQuick.Controls

Component {
    id: cardTitle

    Text {
        text: ""
        font.pixelSize: 24 // text-2xl equivalent
        font.weight: Font.DemiBold
        color: Theme.cardForeground
        lineHeight: 1
        elide: Text.ElideRight
    }
}
