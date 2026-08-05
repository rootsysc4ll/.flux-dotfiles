import Quickshell
import QtQuick

Item {
    readonly property string baseChar: " 単純 "
    readonly property bool motionActive: true
    readonly property int stripAnimDuration: 25000
    readonly property int stripOffset: 100
    readonly property int stripTextPixelSize: 20
    readonly property string stripColor: colors["accent"]
    
    property real stripWidth: Screen.width
    property bool startInfStrip: false
    property string stripText: ""

    // Text {
    //     y: stripOffset
    //     color: stripColor
    //     font.pixelSize: stripTextPixelSize
    //     font.family: "NotoSansCJK-Regular" //"NotoSerifCJK-Regular"
    //     text: stripText

    //     SequentialAnimation on x {
    //         running: startInfStrip
    //         loops: Animation.Infinite
    //         PropertyAnimation { from: -stripWidth; to: 0; duration: stripAnimDuration / 2 }
    //         PropertyAnimation { from: 0; to: stripWidth; duration: stripAnimDuration / 2 }
    //     }

    //     Component.onCompleted: {
    //         var currentText = ""
    //         while (contentWidth < stripWidth) {
    //             currentText += baseChar
    //             text = currentText
    //         }
    //         stripWidth = contentWidth
    //         x = -contentWidth
    //         stripText = text
            
    //         if (!motionActive) { x = (Screen.width - contentWidth) / 2 }
    //     }
    // }
    // Text {
    //     visible: motionActive
    //     y: stripOffset
    //     color: stripColor
    //     font.pixelSize: stripTextPixelSize
    //     font.family: "NotoSansCJK-Regular" //"NotoSerifCJK-Regular"
    //     text: stripText

    //     SequentialAnimation on x {
    //         running: true
    //         loops: Animation.Infinite
    //         PropertyAnimation { from: -stripWidth; to: 0; duration: stripAnimDuration / 2; }
    //         ScriptAction { script: { startInfStrip = true; running = false } }
    //         PropertyAnimation { from: 0; to: stripWidth; duration: stripAnimDuration / 2; }
    //     }
    // }
    // corresponds to :
    Repeater {
        id: topStrips
        model: 2

        Text {
            visible: index === 0 ? true : motionActive
            y: stripOffset
            color: stripColor
            font.pixelSize: stripTextPixelSize
            font.family: "NotoSansCJK-Regular" //"NotoSerifCJK-Regular"
            text: stripText

            SequentialAnimation on x {
                running: index === 0 ? startInfStrip && motionActive : true
                loops: Animation.Infinite
                PropertyAnimation { from: -stripWidth; to: 0; duration: stripAnimDuration / 2 }
                ScriptAction { 
                    script: { if (index === 1) { startInfStrip = true; running = false } } 
                }
                PropertyAnimation { from: 0; to: stripWidth; duration: stripAnimDuration / 2 }
            }

            Component.onCompleted: {
                if (index === 0) {
                    var currentText = ""
                    while (contentWidth < stripWidth) {
                        currentText += baseChar
                        text = currentText
                    }
                    stripWidth = contentWidth
                    x = -contentWidth
                    stripText = text
                    
                    if (!motionActive) { x = (Screen.width - contentWidth) / 2 }
                }
            }
        }
    }

    
    Repeater {
        id: bottomStrips
        model: 2

        Text {
            visible: index === 0 ? true : motionActive
            y: Screen.height - stripOffset
            color: stripColor
            font.pixelSize: stripTextPixelSize
            font.family: "NotoSansCJK-Regular" //"NotoSerifCJK-Regular"
            text: stripText

            SequentialAnimation on x {
                running: index === 0 ? startInfStrip && motionActive : true
                loops: Animation.Infinite
                PropertyAnimation { from: stripWidth; to: 0; duration: stripAnimDuration / 2 }
                ScriptAction { 
                    script: { if (index === 1) { startInfStrip = true; running = false } } 
                }
                PropertyAnimation { from: 0; to: -stripWidth; duration: stripAnimDuration / 2 }
            }

            Component.onCompleted: {
                if (index === 0) {
                    var currentText = ""
                    while (contentWidth < stripWidth) {
                        currentText += baseChar
                        text = currentText
                    }
                    stripWidth = contentWidth
                    x = -contentWidth
                    stripText = text
                    
                    if (!motionActive) { x = (Screen.width - contentWidth) / 2 }
                }
            }
        }
    }
}