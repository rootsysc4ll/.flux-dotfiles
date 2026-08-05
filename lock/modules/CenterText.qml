import Quickshell
import QtQuick.Layouts
import QtQuick

Text {
    readonly property string defaultChar: "錠"
    readonly property string errorChar: "悪"
    readonly property string successChar: "正"
    readonly property int resultDelayTime: 3000
    
    text: {
        if (lockContext.showFailure) { return errorChar }
        else { return defaultChar }
    }
    color: {
        if (lockContext.showFailure) { return "red" }
        else { return lock.colors["accent"] }
    }
    font.family: "NotoSerifCJK-Regular"
    font.pixelSize: 100
    Layout.alignment: Qt.AlignHCenter
}