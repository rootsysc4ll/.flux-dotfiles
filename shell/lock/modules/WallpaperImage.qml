import QtQuick
import QtQuick.Effects
import Quickshell

Image {
    source: lock.wallpaperPath
    anchors.fill: parent

    layer.enabled: true
    layer.effect: MultiEffect {
        autoPaddingEnabled: false
        blurEnabled: true
        blur: 1
        blurMultiplier: 1.5
        blurMax: 48
    }
}