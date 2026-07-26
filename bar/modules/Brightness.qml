import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import ".."

RowLayout {
    readonly property string device_path: "/sys/class/backlight/intel_backlight"
    property int current: 0
    property int maximum: 1
    readonly property real value: maximum > 0 ? current / maximum : 0
    readonly property int percent: Math.round(value * 100)

    property string icon: {
        if (percent <= 15) return String.fromCodePoint(0xf00da)
        return String.fromCodePoint(0xf00db + Math.floor(percent / 15) - 1)
    }

    FileView {
        id: current_file

        path: device_path + "/brightness"
        blockLoading: true
        printErrors: false
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            var parsed = parseInt(text().trim());
            if (!isNaN(parsed)) {
                current = parsed;
            }
        }
    }

    FileView {
        id: max_file

        path: device_path + "/max_brightness"
        blockLoading: true
        printErrors: false
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            var parsed = parseInt(text().trim());
            if (!isNaN(parsed) && parsed > 0) {
                maximum = parsed;
            }
        }
    }

    Text {
        text: icon
        color: percent < 50 ? Colors.colors.dim : Colors.colors.fg
        font {
            family: "JetBrainsMono Nerd Font Regular"
            pixelSize: 16
        }
    }

    Text {
        text: percent + "%"
        color: percent < 50 ? Colors.colors.dim : Colors.colors.fg
        font {
            family: "JetBrainsMono Nerd Font Regular"
            pixelSize: 14
        }
    }
}
