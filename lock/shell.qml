import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "./Colors.qml"
import "./modules"

ShellRoot {
    LockContext { id: lockContext }

    Loader { sourceComponent: Colors.isLoaded ? lockComponent : null }
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

            WlSessionLockSurface {
                color: lock.colors['bg']

                TextStrips {}

                ColumnLayout {
                    anchors.centerIn: parent
                    
                    CenterText { id: centerText }
                    PasswordInput {}
                }
            }
        }
    }
}