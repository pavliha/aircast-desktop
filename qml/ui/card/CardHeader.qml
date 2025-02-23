// CardHeader.qml
import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: headerRoot
    color: "transparent"

    Layout.fillWidth: true
    Layout.preferredHeight: headerLayout.implicitHeight

    default property alias content: headerLayout.children

    ColumnLayout {
        id: headerLayout
        anchors.fill: parent
        spacing: 6
    }
}
