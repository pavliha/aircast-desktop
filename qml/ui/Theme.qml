pragma Singleton
import QtQuick

QtObject {
    // Property to handle dark mode
    property bool isDark: true  // You can toggle this for dark/light mode

    // Helper function to convert HSL to RGB
    function hslToRgb(h, s, l) {
        h = h / 360;
        s = s / 100;
        l = l / 100;

        let r, g, b;

        if (s === 0) {
            r = g = b = l;
        } else {
            function hue2rgb(p, q, t) {
                if (t < 0)
                    t += 1;
                if (t > 1)
                    t -= 1;
                if (t < 1 / 6)
                    return p + (q - p) * 6 * t;
                if (t < 1 / 2)
                    return q;
                if (t < 2 / 3)
                    return p + (q - p) * (2 / 3 - t) * 6;
                return p;
            }

            const q = l < 0.5 ? l * (1 + s) : l + s - l * s;
            const p = 2 * l - q;

            r = hue2rgb(p, q, h + 1 / 3);
            g = hue2rgb(p, q, h);
            b = hue2rgb(p, q, h - 1 / 3);
        }

        return Qt.rgba(r, g, b, 1.0);
    }

    // Light theme colors
    readonly property color _lightBackground: hslToRgb(0, 0, 100)      // --background: 0 0% 100%
    readonly property color _lightForeground: hslToRgb(222.2, 47.4, 11.2)  // --foreground: 222.2 47.4% 11.2%
    readonly property color _lightCard: hslToRgb(0, 0, 100)           // --card: 0 0% 100%
    readonly property color _lightCardForeground: hslToRgb(222.2, 47.4, 11.2)
    readonly property color _lightBorder: hslToRgb(214.3, 31.8, 91.4)  // --border: 214.3 31.8% 91.4%
    readonly property color _lightMutedForeground: hslToRgb(215.4, 16.3, 46.9)  // --muted-foreground

    // Dark theme colors
    readonly property color _darkBackground: hslToRgb(0, 0, 0)        // --background: 0 0% 0%
    readonly property color _darkForeground: hslToRgb(210, 40, 98)    // --foreground: 210 40% 98%
    readonly property color _darkCard: hslToRgb(222.2, 84, 4.9)      // --card: 222.2 84% 4.9%
    readonly property color _darkCardForeground: hslToRgb(210, 40, 98)
    readonly property color _darkBorder: hslToRgb(217.2, 32.6, 17.5)  // --border: 217.2 32.6% 17.5%
    readonly property color _darkMutedForeground: hslToRgb(215, 20.2, 65.1)  // --muted-foreground

    // Dynamic colors based on theme
    readonly property color background: isDark ? _darkBackground : _lightBackground
    readonly property color foreground: isDark ? _darkForeground : _lightForeground
    readonly property color card: isDark ? _darkCard : _lightCard
    readonly property color cardForeground: isDark ? _darkCardForeground : _lightCardForeground
    readonly property color border: isDark ? _darkBorder : _lightBorder
    readonly property color mutedForeground: isDark ? _darkMutedForeground : _lightMutedForeground

    // Other colors remain similar but using HSL values
    readonly property color primary: isDark ? hslToRgb(210, 40, 98) : hslToRgb(222.2, 47.4, 11.2)
    readonly property color primaryForeground: isDark ? hslToRgb(222.2, 47.4, 11.2) : hslToRgb(210, 40, 98)
    readonly property color destructive: isDark ? hslToRgb(0, 62.8, 30.6) : hslToRgb(0, 100, 50)
    readonly property color destructiveForeground: isDark ? hslToRgb(210, 40, 98) : hslToRgb(210, 40, 98)
    readonly property color accent: isDark ? hslToRgb(217.2, 32.6, 17.5) : hslToRgb(210, 40, 96.1)
    readonly property color accentForeground: isDark ? hslToRgb(210, 40, 98) : hslToRgb(222.2, 47.4, 11.2)
    readonly property color secondary: isDark ? hslToRgb(217.2, 32.6, 17.5) : hslToRgb(210, 40, 96.1)
    readonly property color secondaryForeground: isDark ? hslToRgb(210, 40, 98) : hslToRgb(222.2, 47.4, 11.2)
    readonly property color ring: isDark ? hslToRgb(212.7, 26.8, 83.9) : hslToRgb(222.2, 84, 4.9)

    // Border radius matching Tailwind config
    readonly property real radius: 8  // --radius: 0.5rem

    // Original withAlpha function remains the same
    function withAlpha(col, alpha) {
        if (typeof col === 'object') {
            return Qt.rgba(col.r, col.g, col.b, alpha);
        }

        if (typeof col === 'string' && col.startsWith('#')) {
            var r = parseInt(col.substring(1, 3), 16) / 255;
            var g = parseInt(col.substring(3, 5), 16) / 255;
            var b = parseInt(col.substring(5, 7), 16) / 255;
            return Qt.rgba(r, g, b, alpha);
        }

        console.warn("Invalid color format:", col);
        return Qt.rgba(0, 0, 0, alpha);
    }
}
