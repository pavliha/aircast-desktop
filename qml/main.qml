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

    // Instead of creating a new AuthManager, use the one provided by C++
    Component.onCompleted: {
        // Example usage: listen to signals or call methods on authManager
        if (authManager.isAuthenticated) {
            stackView.push(mainPage);
        }
    }

    // Use authManager's signals by connecting to them directly in QML,
    // or if needed, create signal handlers that call methods on authManager.
    // For example:
    Connections {
        target: authManager

        function onSignInSuccessful() {
            console.log("Successfully signed in!");
            stackView.push(mainPage);
        }

        function onAuthStatusChanged() {
            if (authManager.isAuthenticated) {
                if (stackView.currentItem.objectName !== "mainPage") {
                    stackView.push(mainPage);
                }
            } else {
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
            onDeviceConnectRequested: function (deviceId, deviceName) {
                stackView.push(devicePage, {
                    deviceId: deviceId,
                    deviceName: deviceName
                });
            }
        }
    }

    // Add the DevicePage component
    Component {
        id: devicePage
        DevicePage {
            objectName: "devicePage"

            onBackRequested: {
                stackView.pop();
            }
        }
    }
}
