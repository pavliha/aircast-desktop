import QtQuick 2.15

Item {
    id: root
    property url source: ""
    property color tintColor: Theme.foreground

    width: icon.width
    height: icon.height

    ShaderEffect {
        anchors.fill: parent
        property variant src: icon
        property color tintColor: root.tintColor
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
