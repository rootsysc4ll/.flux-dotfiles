import Quickshell
import QtQuick
import QtQuick.Layouts

import ".."

RowLayout {
    anchors.centerIn: parent
    spacing: 10

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Text {
        text: Qt.formatDateTime(clock.date, "MMM - ddd")
        color: Colors.colors.accent
        font {
            family: "JetBrainsMono Nerd Font Regular"
            letterSpacing: -1
            pixelSize: 14
            weight: 600
        }
    }

    Text {
        text: Qt.formatDateTime(clock.date, "hh:mm")
        color: Colors.colors.accent
        font {
            family: "JetBrainsMono Nerd Font Regular"
            letterSpacing: -1
            pixelSize: 14
            weight: 800
        }
    }   
}