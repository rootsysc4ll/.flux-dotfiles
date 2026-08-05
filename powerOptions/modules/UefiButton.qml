import Quickshell
import Quickshell.Io
import QtQuick

Rectangle {
    width: grid.cellSize
    height: grid.cellSize
    color: Qt.rgba(0, 0, 0, 0.01)

    focus: grid.selected === grid.cellsIds[4]
    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Up || event.key === Qt.Key_W) {
            grid.selected = grid.cellsIds[2]
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
            if (!uefiProc.running) {
                uefiProc.startDetached()
                Qt.quit()
            }
        }
    }

    anchors {
        top: shutdown.bottom
        horizontalCenter: shutdown.horizontalCenter
        topMargin: grid.marginLenght
    }
    border.color: focus ? powerOptions.colors["bg"] : "transparent"
    border.width: focus ? grid.borderWidth : 0

    Text {
        color: powerOptions.colors["bg"]
        anchors.centerIn: parent
        text: String.fromCodePoint(0xe322)
        font {
            family: "Material Symbols Sharp"
            pixelSize: grid.cellSize / 2
        }
    }

    Process { id: uefiProc; command: ["sh", "-c", "systemctl reboot --firmware-setup"] }
}