import Quickshell
import QtQuick.Layouts
import QtQuick

Text {
    readonly property string defaultChar: "錠"
    readonly property string errorChar: "悪"
    readonly property string successChar: "正"
    readonly property int animDuration: 1000
    
    text: defaultChar
    color: lock.colors["accent"]
    font.family: "NotoSerifCJK-Regular"
    font.pixelSize: 100
    Layout.alignment: Qt.AlignHCenter

    SequentialAnimation on opacity {
        id: charBlinkAnim
        PropertyAnimation { from: 1; to: 0; duration: animDuration / 2 }
        ScriptAction { script: {
            if (lockContext.showFailure) {
                text = errorChar
                color = "red"
            } else {
                text = defaultChar
                color = lock.colors["accent"]
            }
        } }
        PropertyAnimation { from: 0; to: 1; duration: animDuration / 2 }
    }

    Connections {
        target: lockContext

        function onShowFailureChanged() {
            charBlinkAnim.running = true
        }
    }
}