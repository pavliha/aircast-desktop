// CardFooter
import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    color: "transparent"

    ColumnLayout {
        id: footerLayout
        anchors.fill: parent
        anchors.leftMargin: 24
        anchors.rightMargin: 24
        anchors.bottomMargin: 24
        anchors.topMargin: 0
        spacing: 16  // Similar to space-y-4 in TSX
    }

    default property alias content: footerLayout.data
}
