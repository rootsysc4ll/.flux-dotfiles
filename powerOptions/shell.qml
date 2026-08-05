import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io


import "."

ShellRoot {
    PanelWindow {
        id: "panel"
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
            readonly property int marginLenght: grid.borderWidth * 2
            readonly property int cellSize: 150
            readonly property variant cellsIds: ["reboot", "lock", "shutdown", "sleep", "uefi"]
            property string selected: cellsIds[0]

            Process { id: rebootProc; command:   ["sh", "-c", "systemctl reboot"];                  onExited: Qt.quit(); }
            Process { id: lockProc; command:     ["sh", "-c", "qs -c ~/.flux-dotfiles/lock/"];      onExited: Qt.quit(); }
            Process { id: shutdownProc; command: ["sh", "-c", "systemctl poweroff"];                onExited: Qt.quit(); }
            Process { id: sleepProc; 
                command: ["sh", "-c", "systemctl sleep && qs -c ~/.flux-dotfiles/lock/"];           onExited: Qt.quit();
            }
            Process { id: toUefiProc; command:   ["sh", "-c", "systemctl reboot --firmware-setup"]; onExited: Qt.quit(); }

            anchors.fill: parent
            focus: true
            Keys.onPressed: (event) => {
                if (event.key === Qt.Key_Escape) {
                    Qt.quit()
                }
            }

            Rectangle {
                id: reboot
                width: grid.cellSize
                height: grid.cellSize
                color: Qt.rgba(0, 0, 0, 0.01)

                focus: grid.selected === grid.cellsIds[0]
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Down || event.key === Qt.Key_S) {
                        grid.selected = grid.cellsIds[2]
                    } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
                        if (!rebootProc.running) { rebootProc.running = true }
                    }
                }

                anchors {
                    bottom: shutdown.top
                    horizontalCenter: shutdown.horizontalCenter
                    bottomMargin: grid.marginLenght 
                }
                border.color: focus ? Colors.colors.bg : "transparent"
                border.width: focus ? grid.borderWidth : 0

                Text {
                    color: Colors.colors.bg
                    anchors.centerIn: parent
                    text: String.fromCodePoint(0xe5d5)
                    font {
                        family: "Material Symbols Sharp"
                        pixelSize: grid.cellSize / 2
                    }
                }
            }
            Rectangle {
                id: lock
                width: grid.cellSize
                height: grid.cellSize
                color: Qt.rgba(0, 0, 0, 0.01)

                focus: grid.selected === grid.cellsIds[1]
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Right || event.key === Qt.Key_D) {
                        grid.selected = grid.cellsIds[2]
                    } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
                        if (!lockProc.running) { lockProc.running = true }
                    }
                }

                anchors {
                    right: shutdown.left
                    verticalCenter: shutdown.verticalCenter
                    rightMargin: grid.marginLenght
                }
                border.color: focus ? Colors.colors.bg : "transparent"
                border.width: focus ? grid.borderWidth : 0

                Text {
                    color: Colors.colors.bg
                    anchors.centerIn: parent
                    text: String.fromCodePoint(0xe897)
                    font {
                        family: "Material Symbols Sharp"
                        pixelSize: grid.cellSize / 2
                    }
                }
                
            }
            Rectangle {
                id: shutdown
                width: grid.cellSize
                height: grid.cellSize
                color: Qt.rgba(0, 0, 0, 0.01)

                focus: grid.selected === grid.cellsIds[2]
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Left || event.key === Qt.Key_A) {
                        grid.selected = grid.cellsIds[1]
                    } else if (event.key === Qt.Key_Right || event.key === Qt.Key_D) {
                        grid.selected = grid.cellsIds[3]
                    } else if (event.key === Qt.Key_Up || event.key === Qt.Key_W) {
                        grid.selected = grid.cellsIds[0]
                    } else if (event.key === Qt.Key_Down || event.key === Qt.Key_S) {
                        grid.selected = grid.cellsIds[4]
                    } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
                        if (!shutdownProc.running) { shutdownProc.running = true }
                    }
                }

                anchors {
                    centerIn: parent
                }
                border.color: focus ? Colors.colors.bg : "transparent"
                border.width: focus ? grid.borderWidth : 0

                Text {
                    color: Colors.colors.bg
                    anchors.centerIn: parent
                    text: String.fromCodePoint(0xe8ac)
                    font {
                        family: "Material Symbols Sharp"
                        pixelSize: grid.cellSize / 2
                    }
                }
                
            }
            Rectangle {
                id: sleep
                width: grid.cellSize
                height: grid.cellSize
                color: Qt.rgba(0, 0, 0, 0.01)
                
                focus: grid.selected === grid.cellsIds[3]
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Left || event.key === Qt.Key_A) {
                        grid.selected = grid.cellsIds[2]
                    } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
                        if (!sleepProc.running) { sleepProc.running = true }
                    }
                }

                anchors {
                    left: shutdown.right
                    verticalCenter: shutdown.verticalCenter
                    leftMargin: grid.marginLenght
                }
                border.color: focus ? Colors.colors.bg : "transparent"
                border.width: focus ? grid.borderWidth : 0

                Text {
                    color: Colors.colors.bg
                    anchors.centerIn: parent
                    text: String.fromCodePoint(0xea46)
                    font {
                        family: "Material Symbols Sharp"
                        pixelSize: grid.cellSize / 2
                    }
                }
                
            }
            Rectangle {
                id: uefi
                width: grid.cellSize
                height: grid.cellSize
                color: Qt.rgba(0, 0, 0, 0.01)

                focus: grid.selected === grid.cellsIds[4]
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Up || event.key === Qt.Key_W) {
                        grid.selected = grid.cellsIds[2]
                    } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
                        if (!toUefiProc.running) { toUefiProc.running = true }
                    }
                }

                anchors {
                    top: shutdown.bottom
                    horizontalCenter: shutdown.horizontalCenter
                    topMargin: grid.marginLenght
                }
                border.color: focus ? Colors.colors.bg : "transparent"
                border.width: focus ? grid.borderWidth : 0

                Text {
                    color: Colors.colors.bg
                    anchors.centerIn: parent
                    text: String.fromCodePoint(0xe322)
                    font {
                        family: "Material Symbols Sharp"
                        pixelSize: grid.cellSize / 2
                    }
                }
                
            }
        }
    }
}
