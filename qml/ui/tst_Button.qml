// tst_Button.qml
import QtQuick 2.15
import QtTest 1.2
import "."

Item {
    width: 300
    height: 300

    // Instantiate the Button component.
    Button {
        id: testButton
        anchors.centerIn: parent
    }

    TestCase {
        name: "ButtonTests"

        function initTestCase() {
            QVERIFY(testButton !== null, "Button should be instantiated");
        }

        function testDefaultProperties() {
            compare(testButton.text, "");
            compare(testButton.disabled, false);
            compare(testButton.variant, "default");
            compare(testButton.size, "default");
        }

        function testClickSignal() {
            var wasClicked = false;
            testButton.clicked.connect(function () {
                wasClicked = true;
            });
            // Simulate a click by invoking the MouseArea's onClicked handler.
            // In a real environment you might use QTest.mouseClick() from C++.
            testButton.mouseArea.clicked();
            compare(wasClicked, true, "Click signal should be emitted on click");
        }

        function testDisabledDoesNotEmitClick() {
            testButton.disabled = true;
            var wasClicked = false;
            testButton.clicked.connect(function () {
                wasClicked = true;
            });
            testButton.mouseArea.clicked();
            compare(wasClicked, false, "Click signal should not be emitted when disabled");
        }

        // You could add more tests here to simulate hover, key events, etc.
    }
}
