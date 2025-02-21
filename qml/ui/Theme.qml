pragma Singleton
import QtQuick 2.15

QtObject {
    readonly property color background: "#FFFFFF"
    readonly property color foreground: "#1F2937"
    readonly property color card: "#FFFFFF"
    readonly property color cardForeground: "#1F2937"
    readonly property color border: "#E5E7EB"
    readonly property color mutedForeground: "#6B7280"

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

    // Helper function to adjust alpha.
    // Assumes the color is in the format "#RRGGBB"
    function withAlpha(col, alpha) {
        // If color is already a Qt color object
        if (typeof col === 'object') {
            return Qt.rgba(col.r, col.g, col.b, alpha);
        }

        // If color is a hex string
        if (typeof col === 'string' && col.startsWith('#')) {
            var r = parseInt(col.substring(1, 3), 16) / 255;
            var g = parseInt(col.substring(3, 5), 16) / 255;
            var b = parseInt(col.substring(5, 7), 16) / 255;
            return Qt.rgba(r, g, b, alpha);
        }

        // Fallback
        console.warn("Invalid color format:", col);
        return Qt.rgba(0, 0, 0, alpha);
    }
}
