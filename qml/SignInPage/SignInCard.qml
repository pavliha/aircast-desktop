import QtQuick 2.15
import QtQuick.Layouts 1.15
import myproject 1.0

Card {
    id: root

    // Constrain the card’s size so it doesn’t stretch too wide
    // and center it horizontally in the parent layout.
    Layout.preferredWidth: 400
    Layout.alignment: Qt.AlignHCenter
    Layout.margins: 32
    // If you also want to center it vertically, do Layout.alignment: Qt.AlignCenter
    // in whatever parent layout is wrapping this Card.

    // Header: "Sign in" + "Choose your preferred sign in method"
    header: CardHeader {
        title: CardTitle {
            text: "Sign in"
            horizontalAlignment: Text.AlignHCenter
            color: Theme.foreground
        }
        description: CardDescription {
            text: "Choose your preferred sign in method"
            horizontalAlignment: Text.AlignHCenter
            color: Theme.mutedForeground
        }
    }

    // Content: Google sign in button + branding
    content: CardContent {
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 24

            SignInWithGoogleButton {}

            ProtectedByAirCast {}
        }
    }

    // Footer: text about Terms of Service and Privacy Policy
    footer: CardFooter {
        ColumnLayout {
            Layout.fillWidth: true
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

    signal signInSuccessful
}
