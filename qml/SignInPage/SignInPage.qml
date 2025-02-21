import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import myproject 1.0

Page {
    id: root
    signal signInSuccessful

    background: Rectangle {
        // For a solid dark background:
        color: Theme.background

        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop {
                position: 0.0
                color: "#121212"
            }
            GradientStop {
                position: 1.0
                color: "#0D0D0D"
            }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        width: Math.min(parent.width - 32, 480)
        spacing: 0

        // Brand Section (still visible, but with dark text)
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 8

            Text {
                Layout.fillWidth: true
                text: "Welcome to AirCast"
                color: Theme.foreground
                font.pixelSize: 36
                font.weight: Font.Bold
                horizontalAlignment: Text.AlignHCenter
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
