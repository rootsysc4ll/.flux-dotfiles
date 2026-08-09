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
        blurMax: 64
        colorization: 0.1
        contrast: 0.1
        saturation: 0.9
    }
}