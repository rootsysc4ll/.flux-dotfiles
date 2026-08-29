import QtQuick
import Quickshell
import Quickshell.Wayland

import "./modules"
import shared

ShellRoot {
    Loader { sourceComponent: Colors.isLoaded ? powerOptionsComponent : null }
    Component {
        id: powerOptionsComponent
        PanelWindow {
            id: powerOptions

            readonly property var colors: {
                "bg": Colors.colors.bg
            }
            
            WlrLayershell.layer: WlrLayer.Top
            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            color: Qt.rgba(1, 1, 1, 0)
            anchors {
                left: true
                right: true
                bottom: true
                top: true
            }
            
            Item {
                id: grid

                readonly property int borderWidth: 4
                readonly property int marginLenght: borderWidth * 2
                readonly property int cellSize: 150
                readonly property variant cellsIds: ["reboot", "lock", "shutdown", "sleep", "uefi"]
                property string selected: cellsIds[0]

                anchors.fill: parent
                focus: true
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Escape) {
                        Qt.quit()
                    }
                }

                RebootButton { id: reboot }
                LockButton { id: lock }
                ShutdownButton { id: shutdown }
                SleepButton { id: sleep }
                UefiButton { id: uefi }
            }
        }
    }
}
