// TitleSection
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AircastDesktop 1.0

ColumnLayout {
    spacing: Theme.spacing.xs

    Label {
        text: "Devices"
        color: Theme.foreground
        font.pixelSize: 24
        font.weight: Font.Medium
    }

    Label {
        text: "Manage and connect to your AirCast devices"
        color: Theme.mutedForeground
        font.pixelSize: 14
    }
}
