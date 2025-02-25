import QtQuick 2.15

Item {
    id: root
    property url source: ""
    property color color: Theme.foreground

    width: icon.width
    height: icon.height

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

    ShaderEffect {
        anchors.fill: parent
        property variant src: icon
        property color tintColor: root.color
        fragmentShader: "qrc:/shaders/icon.frag.qsb"
    }

    ShaderEffectSource {
        id: icon
        anchors.fill: parent
        sourceItem: Image {
            anchors.fill: parent
            source: root.source
            fillMode: Image.PreserveAspectFit
        }
        smooth: true
    }
}