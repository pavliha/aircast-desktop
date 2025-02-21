import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "transparent"
    implicitHeight: footerLayout.implicitHeight

    default property alias content: footerLayout.data

    ColumnLayout {
        id: footerLayout
        anchors.fill: parent
        spacing: 16  // space-y-4
    }
}
