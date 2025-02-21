// SignInCard.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import myproject 1.0

Card {
    id: root
    Layout.fillWidth: true
    Layout.topMargin: 32

    header: CardHeader {
        title: CardTitle {
            text: "Sign in"
            horizontalAlignment: Text.AlignHCenter
        }
        description: CardDescription {
            text: "Choose your preferred sign in method"
            horizontalAlignment: Text.AlignHCenter
        }
    }

    content: CardContent {
        ColumnLayout {
            spacing: 24
            width: parent.width

            SignInWithGoogleButton {}
            ProtectedByAirCast {}
        }
    }

    footer: CardFooter {
        ColumnLayout {
            width: parent.width
            spacing: 8

            Text {
                Layout.fillWidth: true
                text: "By clicking continue, you agree to our"
                color: Theme.mutedForeground
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                spacing: 4

                Item {
                    Layout.fillWidth: true
                }  // Spacer

                LinkText {
                    text: "Terms of Service"
                    hoverable: true
                    onClicked: Qt.openUrlExternally("https://aircast.one/terms")
                }

                Text {
                    text: "and"
                    color: Theme.mutedForeground
                    font.pixelSize: 12
                }

                LinkText {
                    text: "Privacy Policy"
                    hoverable: true
                    onClicked: Qt.openUrlExternally("https://aircast.one/privacy")
                }

                Item {
                    Layout.fillWidth: true
                }  // Spacer
            }
        }
    }

    signal signInSuccessful
}
