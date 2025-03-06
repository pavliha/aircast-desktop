// main.qml
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import AircastDesktop 1.0

ApplicationWindow {
    id: window
    width: 1200
    height: 800
    visible: true
    title: "AirCast"
    color: Theme.background

    // Create an instance of AuthManager
    AuthManager {
        id: authManager

        onSignInSuccessful: {
            console.log("Successfully signed in!");
            stackView.push(mainPage);
        }

        onAuthStatusChanged: {
            if (authManager.isAuthenticated) {
                if (stackView.currentItem.objectName !== "mainPage") {
                    stackView.push(mainPage);
                }
            } else {
                // Reset to sign-in page when logged out
                if (stackView.depth > 1) {
                    stackView.pop(null);
                }
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: signInPage
    }

    Component {
        id: signInPage
        SignInPage {
            objectName: "signInPage"
        }
    }

    Component {
        id: mainPage
        MainPage {
            objectName: "mainPage"
            user: authManager.userData || {}
        }
    }

    // Check authentication status on startup
    Component.onCompleted: {
        // If already authenticated, go to main page
        if (authManager.isAuthenticated) {
            stackView.push(mainPage);
        }
    }
}
