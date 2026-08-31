import Quickshell
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 10 

    property var wifiEnabled: Networking.wifiEnabled
    property var wifiDevice: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
    property var activeNetwork: wifiDevice ? wifiDevice.networks.values.find(n => n.connected) : null

    readonly property real signal: activeNetwork ? activeNetwork.signalStrength : 0

    readonly property string icon: {
        if (!wifiEnabled) return String.fromCodePoint(0xf092e)
        if (!activeNetwork) return String.fromCodePoint(0xf092b)

        let tier = signal >= 0.75 ? 4
                 : signal >= 0.50 ? 3
                 : signal >= 0.25 ? 2
                 : 1
                
        return String.fromCodePoint(0xf091f + (tier - 1) * 3)
    }

    Text {
        text: icon 
        color: (!wifiEnabled || !activeNetwork) ? "red" : bar.colors["green"]
        font {
            family: "JetBrainsMono Nerd Font Regular"
            pixelSize: 16
        }
    }

    Text {
        text: {
            if (!wifiEnabled) return "Off"
            if (!activeNetwork) return "Disconnected"

            return activeNetwork.name
        }
        color: (!wifiEnabled || !activeNetwork) ? "red" : bar.colors["green"]
        font {
            family: "JetBrainsMono Nerd Font Regular"
            pixelSize: 14
        }
    }
}