import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Component {
    id: cardContent

    Rectangle {
        color: "transparent"
        implicitHeight: contentItem.implicitHeight + 24 // p-6 equivalent

        Item {
            id: contentItem
            anchors.fill: parent
            anchors.margins: 24 // p-6 equivalent
            anchors.topMargin: 0 // pt-0 equivalent
        }
    }
}
