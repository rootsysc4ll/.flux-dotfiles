import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

import ".."

RowLayout {
    spacing: 3

    property var sink: Pipewire.defaultAudioSink
    PwObjectTracker { objects: [ sink ] }
    
    readonly property bool ready: sink && sink.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int vol: ready ? Math.round(sink.audio.volume * 100) : 0

    readonly property string icon: {
        if (!ready) return String.fromCodePoint(0xf0e08)

        if (muted || vol === 0) return String.fromCodePoint(0xf075f)
        if (vol < 33) return String.fromCodePoint(0xf057f)
        if (vol >= 33 && vol < 66) return String.fromCodePoint(0xf0580)

        return String.fromCodePoint(0xf057e)
    }
 
    Text {
        text: icon
        color: (!ready || muted || vol < 33) ? Colors.colors.yellow : Colors.colors.green
        font {
            family: "JetBrainsMono Nerd Font Regular"
            pixelSize: 16
        }
    }

    Text {
        text: {
            if (!ready) return "-"
            if (muted) return "Muted"

            return vol + "%" 
        }
        color: (!ready || muted || vol < 33) ? Colors.colors.yellow : Colors.colors.green
        font {
            family: "JetBrainsMono Nerd Font Regular"
            pixelSize: 14
            weight: 700
        }
    }
}