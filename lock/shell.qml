import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

import "./modules"
import shared

ShellRoot {
    Process { id: sleep; command: ["sh", "-c", "systemctl sleep"] }
    LockContext { id: lockContext }

    Loader { sourceComponent: Colors.isLoaded && Wallpaper.isLoaded ? lockComponent : null }
    Component {
        id: lockComponent

        WlSessionLock {
            id: lock
            locked: true

            readonly property var colors: {
                "bg": Colors.colors.bg,
                "fg": Colors.colors.fg,
                "accent": Colors.colors.accent
            }
            readonly property var wallpaperPath: Wallpaper.wallpaperPath

            WlSessionLockSurface {
                WallpaperImage {}
                
                TextStrips {}

                ColumnLayout {
                    anchors.centerIn: parent
                    
                    CenterText { id: centerText }
                    PasswordInput {}
                }
            }

            Component.onCompleted: if (Quickshell.env("LOCK_AND_SLEEP")) { sleep.startDetached() }
        }
    }
}