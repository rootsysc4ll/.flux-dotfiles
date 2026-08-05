import Quickshell
import QtQuick
import Quickshell.Io

Rectangle {
    width: grid.cellSize
    height: grid.cellSize
    color: Qt.rgba(0, 0, 0, 0.01)

    focus: grid.selected === grid.cellsIds[0]
    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Down || event.key === Qt.Key_S) {
            grid.selected = grid.cellsIds[2]
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
            if (!rebootProc.running) {
                rebootProc.startDetached()
                Qt.quit()
            }
        }
    }

    anchors {
        bottom: shutdown.top
        horizontalCenter: shutdown.horizontalCenter
        bottomMargin: grid.marginLenght 
    }
    border.color: focus ? powerOptions.colors["bg"] : "transparent"
    border.width: focus ? grid.borderWidth : 0

    Text {
        color: powerOptions.colors["bg"]
        anchors.centerIn: parent
        text: String.fromCodePoint(0xe5d5)
        font {
            family: "Material Symbols Sharp"
            pixelSize: grid.cellSize / 2
        }
    }

    Process { id: rebootProc; command: ["sh", "-c", "systemctl reboot"] }
}