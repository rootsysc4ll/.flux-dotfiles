import Quickshell
import Quickshell.Io
import QtQuick

Rectangle {
    width: grid.cellSize
    height: grid.cellSize
    color: Qt.rgba(0, 0, 0, 0.01)

    focus: grid.selected === grid.cellsIds[1]
    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Right || event.key === Qt.Key_D) {
            grid.selected = grid.cellsIds[2]
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
            if (!lockProc.running) { 
                lockProc.startDetached()
                Qt.quit()
            }
        }
    }

    anchors {
        right: shutdown.left
        verticalCenter: shutdown.verticalCenter
        rightMargin: grid.marginLenght
    }
    border.color: focus ? powerOptions.colors["bg"] : "transparent"
    border.width: focus ? grid.borderWidth : 0

    Text {
        color: powerOptions.colors["bg"]
        anchors.centerIn: parent
        text: String.fromCodePoint(0xe897)
        font {
            family: "Material Symbols Sharp"
            pixelSize: grid.cellSize / 2
        }
    }
    
    Process { id: lockProc; command: ["sh", "-c", 'QML_IMPORT_PATH="$HOME/.flux-dotfiles/shell" qs -p $HOME/.flux-dotfiles/shell/lock/shell.qml'] }
}