// CardContent.qml
import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    color: "transparent"
    implicitHeight: contentColumn.implicitHeight
    Layout.fillWidth: true

    default property alias content: contentColumn.children

    ColumnLayout {
        id: contentColumn
        anchors.fill: parent
        spacing: 16
    }
}
