// PageBackground.qml
import QtQuick
import AircastDesktop 1.0

Rectangle {
    anchors.fill: parent
    color: Theme.background
    gradient: Gradient {
        orientation: Gradient.Vertical
        GradientStop {
            position: 0.0
            color: Theme.isDark ? Theme.card : Theme.background
        }
        GradientStop {
            position: 1.0
            color: Theme.background
        }
    }
}
