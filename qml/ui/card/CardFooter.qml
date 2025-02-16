import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Component {
    id: cardFooter

    Rectangle {
        color: "transparent"
        implicitHeight: footerRow.implicitHeight + 24 // p-6 equivalent

        Row {
            id: footerRow
            anchors.fill: parent
            anchors.margins: 24 // p-6 equivalent
            anchors.topMargin: 0 // pt-0 equivalent
            spacing: 8
        }
    }
}
