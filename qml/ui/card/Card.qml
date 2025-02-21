// Card.qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import myproject 1.0

Rectangle {
    id: root

    // Properties to match shadcn structure
    property alias content: contentLoader.sourceComponent
    property alias header: headerLoader.sourceComponent
    property alias footer: footerLoader.sourceComponent

    // Shadcn styling
    color: Theme.card
    border.color: Theme.border
    border.width: 1
    radius: Theme.radius

    // Multi-layer shadow implementation
    Rectangle {
        id: shadow1
        anchors.fill: parent
        anchors.margins: -1
        radius: parent.radius + 1
        color: "transparent"
        border.color: Qt.rgba(0, 0, 0, 0.1)
        border.width: 1
        z: -1
    }

    Rectangle {
        id: shadow2
        anchors.fill: parent
        anchors.margins: -2
        radius: parent.radius + 2
        color: "transparent"
        border.color: Qt.rgba(0, 0, 0, 0.05)
        border.width: 1
        z: -2
    }

    // Layout structure matching shadcn
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Loader {
            id: headerLoader
            Layout.fillWidth: true
            Layout.margins: 24  // p-6
            Layout.bottomMargin: contentLoader.sourceComponent ? 0 : 24
            visible: sourceComponent !== null
        }

        Loader {
            id: contentLoader
            Layout.fillWidth: true
            Layout.margins: 24  // p-6
            Layout.topMargin: headerLoader.sourceComponent ? 0 : 24
            Layout.bottomMargin: footerLoader.sourceComponent ? 0 : 24
            visible: sourceComponent !== null
        }

        Loader {
            id: footerLoader
            Layout.fillWidth: true
            Layout.margins: 24  // p-6
            Layout.topMargin: contentLoader.sourceComponent ? 0 : 24
            visible: sourceComponent !== null
        }
    }
}
