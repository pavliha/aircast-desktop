pragma Singleton
import QtQuick 2.15

QtObject {
    // Basic colors
    readonly property color background: "#FFFFFF"
    readonly property color foreground: "#1F2937"
    readonly property color card: "#FFFFFF"
    readonly property color cardForeground: "#1F2937"
    readonly property color border: "#E5E7EB"
    readonly property color mutedForeground: "#6B7280"

    // Additional theme colors (example Tailwind-inspired values)
    readonly property color primary: "#3B82F6"           // Blue-500
    readonly property color primaryForeground: "#FFFFFF"
    readonly property color destructive: "#EF4444"        // Red-500
    readonly property color destructiveForeground: "#FFFFFF"
    readonly property color input: "#D1D5DB"              // Gray-300
    readonly property color accent: "#10B981"             // Green-500
    readonly property color accentForeground: "#FFFFFF"
    readonly property color secondary: "#6B7280"          // Gray-500
    readonly property color secondaryForeground: "#FFFFFF"
    readonly property color ring: "#2563EB"               // Blue-600

    // Border radius
    readonly property real radius: 8
}
