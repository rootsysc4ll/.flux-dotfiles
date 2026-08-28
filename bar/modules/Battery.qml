import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 3

    property var battery: UPower.displayDevice
    property bool charging: !UPower.onBattery
    readonly property int level: Math.round(battery.percentage * 100)

    readonly property string icon: {
        if (charging) return String.fromCodePoint(0xf0084)
        if (level < 10) return String.fromCodePoint(0xf0083)
        if (level >= 100) return String.fromCodePoint(0xf0079)
        return String.fromCodePoint(0xf007a + (Math.floor(level / 10) - 1))
    }

    Text {
        text: icon
        color: charging ? bar.colors["green"]
                        : (level <= 40) ? "yellow"
                        : (level <= 15) ? "red"
                        : bar.colors["green"]
        font {
            family: "JetBrainsMono Nerd Font Regular"
            pixelSize: 16
        }
    }

    Text {
        text: level + "%"
        color: charging ? bar.colors["green"]
                        : (level <= 40) ? "yellow"
                        : (level <= 15) ? "red"
                        : bar.colors["green"]
        font {
            family: "JetBrainsMono Nerd Font Regular"
            pixelSize: 14
            weight: 700
        }
    }
}
