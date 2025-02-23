import QtQuick 2.15
import QtQuick.Layouts 1.15
import AircastDesktop 1.0

Rectangle {
    id: root

    property int margin: 24

    default property alias content: layout.data

    color: Theme.card
    border.color: Theme.withAlpha(Theme.border, 0.5)
    border.width: 1
    radius: Theme.radius

    height: layout.implicitHeight + margin * 2

    ColumnLayout {
        id: layout
        anchors.fill: parent
        anchors.margins: 24
        spacing: 16
    }

    Repeater {
        model: 2
        Rectangle {
            anchors.fill: parent
            anchors.margins: -(modelData + 1)
            radius: parent.radius + (modelData + 1)
            color: "transparent"
            border.color: Theme.withAlpha(Theme.border, modelData === 0 ? 0.1 : 0.05)
            border.width: 1
            z: -(modelData + 1)
        }
    }
}
