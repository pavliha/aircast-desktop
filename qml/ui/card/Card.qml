import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15

Rectangle {
    id: root

    // Properties to match React component functionality
    property alias content: contentLoader.sourceComponent
    property alias header: headerLoader.sourceComponent
    property alias footer: footerLoader.sourceComponent
    property string className: ""

    // Default styling to match React/Tailwind
    color: Theme.card
    border.color: Theme.border
    border.width: 1
    radius: Theme.radius

    // Modern Qt6 shadow using multiple rectangles
    Rectangle {
        id: shadow
        anchors.fill: parent
        anchors.margins: -2
        radius: parent.radius + 2
        color: "transparent"
        z: -1

        Rectangle {
            anchors.fill: parent
            color: "#1a000000"
            radius: parent.radius
            opacity: 0.2
        }
    }

    // Layout
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Header
        Loader {
            id: headerLoader
            Layout.fillWidth: true
            Layout.preferredHeight: item ? item.height : 0
            visible: sourceComponent != null
        }

        // Content
        Loader {
            id: contentLoader
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: sourceComponent != null
        }

        // Footer
        Loader {
            id: footerLoader
            Layout.fillWidth: true
            Layout.preferredHeight: item ? item.height : 0
            visible: sourceComponent != null
        }
    }
}
