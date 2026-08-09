pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import QtCore

Singleton {
    property var wallpaperPath: ""
    property bool isLoaded: false

    Process {
        running: true
        command: ["sh", "-c", "awww query"]
        stdout: SplitParser {
            onRead: data => {
                var text = data.trim()
                wallpaperPath = text.slice(data.search("image")).split(":")[1].trim()
                isLoaded = true
            }
        }
    }
}