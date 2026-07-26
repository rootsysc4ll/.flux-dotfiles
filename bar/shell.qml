import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "./modules"

ShellRoot {
	WlrLayershell.namespace: "quickshell"

    PanelWindow {
		property int barHeight: 30

		color: Qt.rgba(0, 0, 0, 0.01)
		anchors {
			top: true
			left: true
			right: true
		}
        implicitHeight: barHeight
		WlrLayershell.layer: WlrLayer.Bottom
		aboveWindows: true

		RowLayout {
			anchors.fill: parent
			anchors.leftMargin: 12
			anchors.rightMargin: 12
			anchors.centerIn: parent

			Workspaces {}

			Item {
				Layout.fillWidth: true
			}

			RowLayout {
				spacing: 30
			
				Brightness {}
				Volume {}
				Network {}
				Battery {}
			}
		}

		Clock {}
    }
}
