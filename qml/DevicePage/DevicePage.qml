import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import AircastDesktop 1.0
import QtMultimedia

Controls.Page {
    id: root
    padding: 0 // Remove any default padding

    // Properties to receive device data
    property string deviceId: ""

    // Get the device name from the DeviceManager
    property string deviceName: {
        if (deviceId) {
            var device = deviceManager.getDeviceById(deviceId);
            return device.name || "Unnamed Device";
        }
        return "Device";
    }

    // RTSP stream settings
    property string rtspUrl: "rtsp://127.0.0.1:8554/stream"
    property bool isStreamLoaded: false

    // Default port for MavLink connection
    property int mavlinkPort: 14550
    property string mavlinkIp: "127.0.0.1"
    property bool isConnected: false

    // Mock video parameters (replace with actual video source)
    property bool isVideoConnected: false
    property real altitude: 120.5
    property real speed: 15.2
    property real heading: 275.0
    property real batteryLevel: 85
    property real latitude: 37.7749
    property real longitude: -122.4194

    signal backRequested

    // Page background - full black
    Rectangle {
        anchors.fill: parent
        color: "black"
        z: -1
    }

    // Main content - TRUE fullscreen video (no header)
    Rectangle {
        id: videoContainer
        anchors.fill: parent
        anchors.bottomMargin: 30 // Fixed margin for bottom area
        color: "black"
        clip: true

        // Back button (floating in top-left corner instead of in header)
        Button {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 8
            z: 10 // Ensure it's above video
            width: 32
            height: 32

            variant: "ghost"
            size: "icon"

            contentItem: Icon {
                source: "qrc:/AircastDesktop/assets/icons/arrow-left.svg"
                color: "white" // White color for visibility on dark background
                size: 16
                anchors.centerIn: parent
            }

            onClicked: {
                root.backRequested();
            }
        }

        // RTSP Video Feed with fallback
        Item {
            id: videoFeedContainer
            anchors.fill: parent

            MediaPlayer {
                id: mediaPlayer
                source: root.rtspUrl
                videoOutput: videoOutput

                onErrorOccurred: function (error, errorString) {
                    console.error("Media player error:", error, errorString);
                    root.isStreamLoaded = false;
                }

                onPlaybackStateChanged: function (state) {
                    if (state === MediaPlayer.PlayingState) {
                        root.isStreamLoaded = true;
                        root.isVideoConnected = true;
                    }
                }
            }

            VideoOutput {
                id: videoOutput
                anchors.fill: parent
                fillMode: VideoOutput.PreserveAspectFit
                visible: root.isStreamLoaded
            }

            // Connect button - shown when autoplay fails
            Button {
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 8
                z: 10
                text: "Play Stream"
                visible: !root.isStreamLoaded && root.isVideoConnected

                onClicked: {
                    mediaPlayer.play();
                }
            }
        }

        // HUD Overlay Elements
        Item {
            id: hudOverlay
            anchors.fill: parent
            visible: root.isVideoConnected
            z: 5 // Above video but below controls

            // Device name (floating in top-center instead of in header)
            Rectangle {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 8
                height: 30
                width: deviceNameLabel.width + 20
                color: "#40000000" // Semi-transparent black
                radius: 4

                Controls.Label {
                    id: deviceNameLabel
                    anchors.centerIn: parent
                    text: root.deviceName
                    color: "white"
                    font.pixelSize: 14
                    font.weight: Font.Medium
                }
            }

            // Artificial Horizon
            Rectangle {
                id: horizonIndicator
                anchors.centerIn: parent
                width: parent.width * 0.8
                height: 2
                color: "#80FFFFFF" // Semi-transparent white
            }

            // Compass/Heading Indicator
            Rectangle {
                id: compassContainer
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 45 // Moved down to account for device name
                width: 200
                height: 30
                color: "#40000000" // Semi-transparent black
                radius: 4

                Row {
                    anchors.centerIn: parent
                    spacing: 5

                    Icon {
                        source: "qrc:/AircastDesktop/assets/icons/compass.svg"
                        color: "white"
                        size: 16
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Controls.Label {
                        text: root.heading.toFixed(1) + "°"
                        color: "white"
                        font.pixelSize: 14
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            // Altitude Indicator (Left)
            Rectangle {
                id: altitudeContainer
                anchors.left: parent.left
                anchors.leftMargin: Theme.spacing.md
                anchors.verticalCenter: parent.verticalCenter
                width: 80
                height: 150
                color: "#40000000" // Semi-transparent black
                radius: 4

                Column {
                    anchors.centerIn: parent
                    spacing: 5

                    Icon {
                        source: "qrc:/AircastDesktop/assets/icons/arrow-up.svg"
                        color: "white"
                        size: 16
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Controls.Label {
                        text: root.altitude.toFixed(1) + " m"
                        color: "white"
                        font.pixelSize: 14
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    // Altitude bar
                    Rectangle {
                        width: 10
                        height: 80
                        color: "#40FFFFFF"
                        anchors.horizontalCenter: parent.horizontalCenter

                        Rectangle {
                            width: parent.width
                            height: Math.min(parent.height * (root.altitude / 500), parent.height)
                            anchors.bottom: parent.bottom
                            color: Theme.primary
                        }
                    }
                }
            }

            // Speed Indicator (Right)
            Rectangle {
                id: speedContainer
                anchors.right: parent.right
                anchors.rightMargin: Theme.spacing.md
                anchors.verticalCenter: parent.verticalCenter
                width: 80
                height: 150
                color: "#40000000" // Semi-transparent black
                radius: 4

                Column {
                    anchors.centerIn: parent
                    spacing: 5

                    Icon {
                        source: "qrc:/AircastDesktop/assets/icons/wind.svg"
                        color: "white"
                        size: 16
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Controls.Label {
                        text: root.speed.toFixed(1) + " m/s"
                        color: "white"
                        font.pixelSize: 14
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    // Speed bar
                    Rectangle {
                        width: 10
                        height: 80
                        color: "#40FFFFFF"
                        anchors.horizontalCenter: parent.horizontalCenter

                        Rectangle {
                            width: parent.width
                            height: Math.min(parent.height * (root.speed / 30), parent.height)
                            anchors.bottom: parent.bottom
                            color: Theme.accent
                        }
                    }
                }
            }

            // Battery Indicator (Bottom)
            Rectangle {
                id: batteryContainer
                anchors.right: parent.right
                anchors.rightMargin: Theme.spacing.md
                anchors.bottom: parent.bottom
                anchors.bottomMargin: Theme.spacing.md
                width: 100
                height: 30
                color: "#40000000" // Semi-transparent black
                radius: 4

                Row {
                    anchors.centerIn: parent
                    spacing: 5

                    Icon {
                        source: "qrc:/AircastDesktop/assets/icons/battery.svg"
                        color: getBatteryColor(root.batteryLevel)
                        size: 16
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Controls.Label {
                        text: root.batteryLevel + "%"
                        color: "white"
                        font.pixelSize: 14
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            // GPS Coordinates (Bottom Left)
            Rectangle {
                id: gpsContainer
                anchors.left: parent.left
                anchors.leftMargin: Theme.spacing.md
                anchors.bottom: parent.bottom
                anchors.bottomMargin: Theme.spacing.md
                width: 180
                height: 30
                color: "#40000000" // Semi-transparent black
                radius: 4

                Row {
                    anchors.centerIn: parent
                    spacing: 5

                    Icon {
                        source: "qrc:/AircastDesktop/assets/icons/map-pin.svg"
                        color: "white"
                        size: 16
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Controls.Label {
                        text: root.latitude.toFixed(4) + ", " + root.longitude.toFixed(4)
                        color: "white"
                        font.pixelSize: 12
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

        // No video connected overlay
        ColumnLayout {
            anchors.centerIn: parent
            spacing: Theme.spacing.md
            visible: !root.isVideoConnected

            Icon {
                source: "qrc:/AircastDesktop/assets/icons/video-off.svg"
                color: "white"
                size: 48
                Layout.alignment: Qt.AlignHCenter
            }

            Controls.Label {
                text: "No Video Feed Connected"
                color: "white"
                font.pixelSize: 16
                Layout.alignment: Qt.AlignHCenter
            }

            Button {
                text: "Connect Video"
                variant: "primary"
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    // Connect to RTSP stream
                    root.isVideoConnected = true;
                    mediaPlayer.play();
                }
            }
        }
    }

    // Ultra-minimal bottom bar
    Rectangle {
        id: connectionBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 30
        color: "#80000000" // Very dark semi-transparent black
        z: 10

        // Content row
        Row {
            anchors.fill: parent
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            spacing: 4

            // MavLink info - just text
            Controls.Label {
                text: "MavLink: " + root.mavlinkIp + ":" + root.mavlinkPort
                color: "white"
                font.pixelSize: 11
                anchors.verticalCenter: parent.verticalCenter
            }

            Item {
                width: 8
                height: 1
            } // Small spacer

            // Status dot
            Rectangle {
                width: 8
                height: 8
                radius: 4
                color: root.isConnected ? "#4CAF50" : "#F44336" // Green or Red
                anchors.verticalCenter: parent.verticalCenter
            }

            Controls.Label {
                text: root.isConnected ? "Connected" : "Disconnected"
                color: "white"
                font.pixelSize: 11
                anchors.verticalCenter: parent.verticalCenter
            }

            Item {
                width: 1
                height: 1
                Layout.fillWidth: true
            } // Flexible spacer

            // Connect button - smaller with icon
            Button {
                id: connectButton
                anchors.verticalCenter: parent.verticalCenter
                implicitWidth: 80
                implicitHeight: 24

                text: root.isConnected ? "Disconnect" : "Connect"

                onClicked: {
                    if (root.isConnected) {
                        console.log("Disconnecting from", root.mavlinkIp + ":" + root.mavlinkPort);
                        root.isConnected = false;
                    } else {
                        console.log("Connecting to", root.mavlinkIp + ":" + root.mavlinkPort);
                        root.isConnected = true;
                    }
                }
            }
        }
    }

    // Initialize the MediaPlayer
    Component.onCompleted: {
        if (root.isVideoConnected) {
            mediaPlayer.play();
        }
    }

    // Helper function to determine battery color based on level
    function getBatteryColor(level) {
        if (level > 50)
            return "#4CAF50"; // Green
        if (level > 20)
            return "#FFC107"; // Yellow/Amber
        return "#F44336"; // Red for low battery
    }
}
