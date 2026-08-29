import Quickshell
import Quickshell.Io
import QtQuick

Rectangle {
    width: grid.cellSize
    height: grid.cellSize
    color: Qt.rgba(0, 0, 0, 0.01)
    
    focus: grid.selected === grid.cellsIds[3]
    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Left || event.key === Qt.Key_A) {
            grid.selected = grid.cellsIds[2]
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
            if (!sleepProc.running) {
                sleepProc.startDetached()
                Qt.quit()
            }
        }
    }

    anchors {
        left: shutdown.right
        verticalCenter: shutdown.verticalCenter
        leftMargin: grid.marginLenght
    }
    border.color: focus ? powerOptions.colors["bg"] : "transparent"
    border.width: focus ? grid.borderWidth : 0

    Text {
        color: powerOptions.colors["bg"]
        anchors.centerIn: parent
        text: String.fromCodePoint(0xea46)
        font {
            family: "Material Symbols Sharp"
            pixelSize: grid.cellSize / 2
        }
    }

    Process { 
        id: sleepProc 
        command: ["sh", "-c", 'LOCK_AND_SLEEP=true XDG_CONFIG_HOME="$HOME/.flux-dotfiles/" QML_IMPORT_PATH="$HOME/.flux-dotfiles/" qs -p $HOME/.flux-dotfiles/lock/shell.qml']
    }
}