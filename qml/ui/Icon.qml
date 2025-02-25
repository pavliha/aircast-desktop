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

    // Log color when it changes
    onColorChanged: {
        console.log("Icon color changed to:", color)
        logColor(color)
    }

    // Log initial color when component completes
    Component.onCompleted: {
        console.log("Icon initial color:", color)
        logColor(color)
    }

    // Function to log color in a more detailed format
    function logColor(colorValue) {
        console.log("Color RGB values - R:", colorValue.r.toFixed(2), 
                                     "G:", colorValue.g.toFixed(2), 
                                     "B:", colorValue.b.toFixed(2), 
                                     "A:", colorValue.a.toFixed(2))
    }

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