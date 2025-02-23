import QtQuick 2.15
import QtQuick.Layouts 1.15
import AircastDesktop 1.0

Card {
    CardHeader {
        CardTitle {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            text: "Sign in"
        }
        CardDescription {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            text: "Choose your preferred sign in method"
        }
    }

    CardContent {
        SignInWithGoogleButton {}
        ProtectedByAirCast {}
    }

    CardFooter {
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
