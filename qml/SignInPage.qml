import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import myproject 1.0

Page {
    id: root
    signal signInSuccessful

    background: Rectangle {
        color: Theme.background

        // Gradient overlay using Qt6 native gradient
        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop {
                position: 0.0
                color: Theme.primary
            }
            GradientStop {
                position: 1.0
                color: Theme.background
            }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        width: Math.min(parent.width - 32, 480) // px-4 with max-w-md
        spacing: 0

        // Brand Section
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 8

            Text {
                Layout.fillWidth: true
                text: "Welcome to AirCast"
                color: Theme.foreground
                font.pixelSize: 36 // text-4xl
                font.weight: Font.Bold
                horizontalAlignment: Text.AlignHCenter

                // Animation for scale
                scale: 1
                Behavior on scale {
                    NumberAnimation {
                        duration: 200
                    }
                }
                Component.onCompleted: scale = 1
            }

            Text {
                Layout.fillWidth: true
                text: "Stream and manage your devices with ease"
                color: Theme.mutedForeground
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // Sign In Card
        Card {
            Layout.fillWidth: true
            Layout.topMargin: 32

            header: CardHeader {
                // text: "Sign in"
                // horizontalAlignment: Text.AlignHCenter
                CardTitle {}
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
                        id: googleButton  // add an id so we can refer to its properties
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
                                    // Use the button’s hovered property
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
                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40

                        Rectangle {
                            anchors.centerIn: parent
                            width: parent.width
                            height: 1
                            color: Theme.border
                        }

                        Rectangle {
                            anchors.centerIn: parent
                            width: protectedText.width + 16
                            height: protectedText.height
                            color: Theme.card
                        }

                        Text {
                            id: protectedText
                            anchors.centerIn: parent
                            text: "PROTECTED BY AIRCAST"
                            color: Theme.mutedForeground
                            font.pixelSize: 12
                            font.weight: Font.Medium
                        }
                    }
                }
            }

            footer: CardFooter {
                ColumnLayout {
                    // Child items will be assigned to the CardFooter’s default "content" property
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

        // Support Section
        RowLayout {
            Layout.fillWidth: true
            Layout.topMargin: 16
            Layout.alignment: Qt.AlignHCenter
            spacing: 4

            Text {
                text: "Need help?"
                color: Theme.mutedForeground
                font.pixelSize: 14
            }

            LinkText {
                text: "Contact Support"
                font.pixelSize: 14
                font.weight: Font.Medium
                hoverable: true
                onClicked: Qt.openUrlExternally("https://aircast.one/support")
            }
        }
    }
}
