import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import myproject 1.0

Card {
    Layout.fillWidth: true
    Layout.topMargin: 32

    // Use dark card color and white text
    color: Theme.card
    // If your custom Card component uses Theme.card internally,
    // that is enough. But ensure it references a dark color.

    header: CardHeader {
        CardTitle {
            text: "Sign in"
            horizontalAlignment: Text.AlignHCenter
        }
        CardDescription {
            text: "Choose your preferred sign in method"
            horizontalAlignment: Text.AlignHCenter
        }
    }

    content: CardContent {
        ColumnLayout {
            spacing: 16
            width: parent.width

            // Google Sign In Button
            Button {
                id: googleButton
                Layout.fillWidth: true
                variant: "outline"
                size: "lg"

                contentItem: Component {
                    RowLayout {
                        spacing: 12
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
                        }
                        Image {
                            id: arrowIcon
                            source: "qrc:/myproject/assets/icons/arrow-right.svg"
                            sourceSize: Qt.size(16, 16)
                            opacity: googleButton.hovered ? 1 : 0
                            x: googleButton.hovered ? 0 : -8

                            Behavior on opacity {
                                NumberAnimation {
                                    duration: 150
                                }
                            }
                            Behavior on x {
                                NumberAnimation {
                                    duration: 150
                                }
                            }
                        }
                    }
                }

                onClicked: root.signInSuccessful()
            }

            // Protected Text with Separator
            ProtectedByAirCast {}
        }
    }

    footer: CardFooter {
        ColumnLayout {
            width: parent.width
            spacing: 16

            Text {
                Layout.fillWidth: true
                text: "By clicking continue, you agree to our"
                color: Theme.mutedForeground
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 4

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
            }
        }
    }
}
