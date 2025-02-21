import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import myproject 1.0

Card {
    id: signInCard
    Layout.fillWidth: true
    Layout.topMargin: 32

    // Use dark card color
    color: Theme.card

    header: CardHeader {
        title: CardTitle {
            text: "Sign in"
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }
        description: CardDescription {
            text: "Choose your preferred sign in method"
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }
    }

    content: CardContent {
        ColumnLayout {
            id: contentLayout
            width: parent.width
            spacing: 24  // Increased spacing between button and separator

            // Google Sign In Button
            Button {
                id: googleButton
                Layout.fillWidth: true
                variant: "outline"
                size: "lg"
                height: 40  // Explicit height to match design

                contentItem: RowLayout {
                    spacing: 12
                    Item {
                        // Left spacing
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

            // Protected Text with Separator
            ProtectedByAirCast {
                Layout.fillWidth: true
                Layout.topMargin: 8
            }
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
}
