import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import myproject 1.0

Button {
    id: googleButton
    Layout.fillWidth: true
    variant: "outline"
    size: "lg"

    contentItem: RowLayout {
        spacing: 12

        Item {
            Layout.preferredWidth: 12
        }

        Image {
            source: "qrc:/myproject/assets/icons/google.svg"
            sourceSize: Qt.size(20, 20)
        }

        Text {
            text: "Continue with Google"
            color: Theme.foreground
            font.pixelSize: 14
            font.weight: Font.Medium
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        Image {
            id: arrowIcon
            source: "qrc:/myproject/assets/icons/arrow-right.svg"
            sourceSize: Qt.size(16, 16)
            opacity: googleButton.hovered ? 1 : 0
            Layout.preferredWidth: 16
            Layout.rightMargin: 12

            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }
        }
    }

    onClicked: root.signInSuccessful()
}
