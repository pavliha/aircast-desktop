import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

Window {
    width: 320
    height: 240
    visible: true
    title: "Interactive Hello World"
    color: "#f0f0f0"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        Label {
            id: messageLabel
            Layout.alignment: Qt.AlignHCenter
            text: "Hello " + (nameInput.text || "World") + "!"
            font.pixelSize: 24
            color: "#2196F3"
        }

        TextField {
            id: nameInput
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            placeholderText: "Enter your name"
            font.pixelSize: 16
        }

        Button {
            Layout.alignment: Qt.AlignHCenter
            text: "Clear"
            onClicked: nameInput.text = ""
        }

        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            Layout.preferredHeight: 2
            color: "#2196F3"
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            text: "Made with Qt Quick"
            font.pixelSize: 12
            color: "#666666"
        }
    }
}