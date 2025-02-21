import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "transparent"
    implicitHeight: contentItem.implicitHeight + 24 // p-6 equivalent

    // Expose a default property for child items
    default property alias content: contentItem.data

    Item {
        id: contentItem
        anchors.fill: parent
        anchors.margins: 24 // p-6 equivalent
        anchors.topMargin: 0 // pt-0 equivalent
    }
}
