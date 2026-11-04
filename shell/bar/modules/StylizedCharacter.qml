import QtQuick
import QtQuick.Effects

Text {
    id: character
    text: "棒"
    anchors.centerIn: parent
    color: bar.colors["fg"]
    font {
        pixelSize: 120
    }

    transform: Rotation {
        origin.x: character.width / 2; 
        origin.y: character.height / 2; 
        axis { x: 2; y: 1; z: 0 } 
        angle: 70
    } 

    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: bar.colors["accent"]
        shadowBlur: 0
        shadowHorizontalOffset: -35
        shadowVerticalOffset: 35
    }
}