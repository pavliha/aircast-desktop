import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import AircastDesktop 1.0

Button {
    id: googleButton
    Layout.fillWidth: true
    variant: "outline"
    size: "lg"

    // Add states for the sign-in process
    property bool isLoading: false

    contentItem: RowLayout {
        spacing: 12

        Item {
            Layout.preferredWidth: 12
        }

        Item {
            Layout.preferredWidth: 20
            Layout.preferredHeight: 20

            Image {
                anchors.fill: parent
                source: "qrc:/AircastDesktop/assets/icons/google.svg"
                sourceSize: Qt.size(20, 20)
                visible: !googleButton.isLoading
            }

            Controls.BusyIndicator {
                anchors.fill: parent
                running: googleButton.isLoading
                visible: googleButton.isLoading
                // You may need to adjust this based on your theme
                palette.dark: Theme.primary
            }
        }

        Text {
            text: googleButton.isLoading ? "Signing in..." : "Continue with Google"
            color: Theme.foreground
            font.pixelSize: 14
            font.weight: Font.Medium
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        Icon {
            id: arrowIcon
            source: "qrc:/AircastDesktop/assets/icons/arrow-right.svg"
            width: 16
            height: 16
            color: Theme.foreground
            opacity: googleButton.hovered && !googleButton.isLoading ? 1 : 0
            Layout.preferredWidth: 16
            Layout.rightMargin: 12

            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }
        }
    }

    // Connect to the AuthManager
    onClicked: {
        if (!isLoading) {
            isLoading = true;
            authManager.startGoogleSignIn();
        }
    }

    // Connect to the AuthManager's signals
    Connections {
        target: authManager

        function onSignInSuccessful() {
            googleButton.isLoading = false;
            root.signInSuccessful();
        }

        function onSignInFailed(message) {
            googleButton.isLoading = false;
            // You might want to show an error message here
            console.error("Sign-in failed:", message);
        }
    }
}
