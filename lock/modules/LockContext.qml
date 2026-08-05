import QtQuick
import Quickshell
import Quickshell.Services.Pam

Scope {
    property string currentText: ""
    property bool unlockInProgress: false
    property bool showFailure: false

    signal unlocked()
    signal failed()

    function tryUnlock() {
        if (currentText === "") { return }

        unlockInProgress = true
        pam.start()
    }

    onCurrentTextChanged: showFailure = false

    PamContext {
        id: pam

        configDirectory: "../pam"
        config: "qs"

        onPamMessage: {
            if (responseRequired) {
                respond(currentText);
            }
        }

        onCompleted: result => {
            if (result === PamResult.Success) {
                unlocked()
            } else {
                currentText = ""
                showFailure = true
                failed()
            }

            unlockInProgress = false;
        }
    }
}
