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

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: signInPage
    }

    Component {
        id: signInPage
        SignInPage {
            onSignInSuccessful: {
                stackView.push(mainPage);
            }
        }
    }

    Component {
        id: mainPage
        MainPage {}
    }
}
