// Card.qml
import QtQuick
import QtQuick.Layouts
import myproject 1.0

Rectangle {
    id: root

    // Properties to match shadcn structure
    property alias content: contentLoader.sourceComponent
    property alias header: headerLoader.sourceComponent
    property alias footer: footerLoader.sourceComponent

    // Implicit sizing based on content
    implicitWidth: mainLayout.implicitWidth
    implicitHeight: mainLayout.implicitHeight

    // Shadcn styling using Theme colors
    color: Theme.card
    border.color: Theme.withAlpha(Theme.border, 0.5)
    border.width: 1
    radius: Theme.radius

    // Multi-layer shadow implementation using repeater for efficiency
    Repeater {
        model: 2

        Rectangle {
            anchors.fill: parent
            anchors.margins: -(modelData + 1)
            radius: parent.radius + (modelData + 1)
            color: "transparent"
            border.color: Theme.withAlpha(Theme.border, modelData === 0 ? 0.1 : 0.05)
            border.width: 1
            z: -(modelData + 1)
        }
    }

    // Layout structure matching shadcn
    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        spacing: 0

        Loader {
            id: headerLoader
            Layout.fillWidth: true
            Layout.margins: 24  // p-6
            Layout.bottomMargin: contentLoader.sourceComponent ? 0 : 24
            visible: sourceComponent !== null

            // Ensure proper implicit size
            onLoaded: {
                if (item) {
                    item.Layout.preferredWidth = Qt.binding(() => item.implicitWidth);
                    item.Layout.preferredHeight = Qt.binding(() => item.implicitHeight);
                }
            }
        }

        Loader {
            id: contentLoader
            Layout.fillWidth: true
            Layout.margins: 24  // p-6
            Layout.topMargin: headerLoader.sourceComponent ? 0 : 24
            Layout.bottomMargin: footerLoader.sourceComponent ? 0 : 24
            visible: sourceComponent !== null

            // Ensure proper implicit size
            onLoaded: {
                if (item) {
                    item.Layout.preferredWidth = Qt.binding(() => item.implicitWidth);
                    item.Layout.preferredHeight = Qt.binding(() => item.implicitHeight);
                }
            }
        }

        Loader {
            id: footerLoader
            Layout.fillWidth: true
            Layout.margins: 24  // p-6
            Layout.topMargin: contentLoader.sourceComponent ? 0 : 24
            visible: sourceComponent !== null

            // Ensure proper implicit size
            onLoaded: {
                if (item) {
                    item.Layout.preferredWidth = Qt.binding(() => item.implicitWidth);
                    item.Layout.preferredHeight = Qt.binding(() => item.implicitHeight);
                }
            }
        }
    }
}
