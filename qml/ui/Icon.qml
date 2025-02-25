import QtQuick
import Qt5Compat.GraphicalEffects

Item {
    id: root
    property url source: ""
    property color color: Theme.foreground
    property int iconWidth: 24
    property int iconHeight: 24

    width: iconWidth
    height: iconHeight

    Image {
        id: sourceImage
        anchors.fill: parent
        source: root.source
        fillMode: Image.PreserveAspectFit
        sourceSize.width: root.width * 2
        sourceSize.height: root.height * 2
        smooth: true
        mipmap: true
        visible: false
    }

    ColorOverlay {
        anchors.fill: sourceImage
        source: sourceImage
        color: root.color
        antialiasing: true
    }
}