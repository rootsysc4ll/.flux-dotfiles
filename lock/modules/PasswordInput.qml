import QtQuick
import Quickshell

TextInput {
    readonly property int maximumPasswLen: 20
    readonly property int passwPixelSize: 20

    focus: true
    enabled: !lockContext.unlockInProgress
    
    maximumLength: maximumPasswLen
    echoMode: TextInput.Password
    passwordCharacter: "^"
    color: lock.colors["bg"]
    selectedTextColor: lock.colors['fg'] 
    selectionColor: lock.colors["accent"]
    cursorDelegate: Rectangle { width: 2; color: lock.colors["bg"]; }
    font.pixelSize: passwPixelSize

    onTextChanged: lockContext.currentText = text
    onAccepted: lockContext.tryUnlock()
    
    Connections {
        target: lockContext
        
        function onCurrentTextChanged() {
            text = lockContext.currentText;
        }
        
        function onUnlocked() {
            lock.locked = false
            Qt.quit()
        }
    }
}
