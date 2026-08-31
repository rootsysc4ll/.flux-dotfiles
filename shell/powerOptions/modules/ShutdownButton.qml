import Quickshell
import QtQuick
import Quickshell.Io

Rectangle {
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
            if (!shutdownProc.running) {
                shutdownProc.startDetached()
                Qt.quit()
            }
        }
    }

    anchors {
        centerIn: parent
    }
    border.color: focus ? powerOptions.colors["bg"] : "transparent"
    border.width: focus ? grid.borderWidth : 0

    Text {
        color: powerOptions.colors["bg"]
        anchors.centerIn: parent
        text: String.fromCodePoint(0xe8ac)
        font {
            family: "Material Symbols Sharp"
            pixelSize: grid.cellSize / 2
        }
    }
    
    Process { id: shutdownProc; command: ["sh", "-c", "systemctl poweroff"] }
}