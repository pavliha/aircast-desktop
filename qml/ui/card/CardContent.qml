import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "transparent"
    implicitHeight: contentColumn.implicitHeight

    default property alias content: contentColumn.data

    ColumnLayout {
        id: contentColumn
        anchors.fill: parent
        spacing: 16  // space-y-4
    }
}
