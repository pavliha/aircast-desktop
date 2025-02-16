import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "transparent"
    implicitHeight: headerLayout.implicitHeight + 24 // p-6 equivalent

    property alias title: titleLoader.sourceComponent
    property alias description: descriptionLoader.sourceComponent

    ColumnLayout {
        id: headerLayout
        anchors.fill: parent
        anchors.margins: 24 // p-6 equivalent
        spacing: 6 // space-y-1.5 equivalent

        // Title slot
        Loader {
            id: titleLoader
            Layout.fillWidth: true
            visible: sourceComponent != null
        }

        // Description slot
        Loader {
            id: descriptionLoader
            Layout.fillWidth: true
            visible: sourceComponent != null
        }
    }
}
