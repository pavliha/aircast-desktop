import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import myproject 1.0

ApplicationWindow {
    id: window
    width: 1200
    height: 800
    visible: true
    title: "AirCast"
    color: "#000000"

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
