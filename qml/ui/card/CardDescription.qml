import QtQuick
import QtQuick.Controls

Component {
    id: cardDescription

    Text {
        text: ""
        font.pixelSize: 14 // text-sm equivalent
        color: Theme.mutedForeground
        wrapMode: Text.WordWrap
    }
}
