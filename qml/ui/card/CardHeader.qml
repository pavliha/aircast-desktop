import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "transparent"
    implicitHeight: headerLayout.implicitHeight

    property alias title: titleLoader.sourceComponent
    property alias description: descriptionLoader.sourceComponent

    ColumnLayout {
        id: headerLayout
        anchors.fill: parent
        spacing: 6  // space-y-1.5

        Loader {
            id: titleLoader
            Layout.fillWidth: true
            visible: sourceComponent !== null
        }

        Loader {
            id: descriptionLoader
            Layout.fillWidth: true
            visible: sourceComponent !== null
        }
    }
}
