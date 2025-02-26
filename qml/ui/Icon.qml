import QtQuick
import Qt5Compat.GraphicalEffects

Item {
    id: root
    property url source: ""
    property color color: Theme.foreground
    property int size: 24

    width: size
    height: size

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
