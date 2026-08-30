import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import qs.modules
import shared

ShellRoot {
	WlrLayershell.namespace: "quickshell"

	Loader { sourceComponent: Colors.isLoaded ? barComponent : null }
	Component {
		id: barComponent
		PanelWindow {
			id: bar

			property int barHeight: 30
			readonly property var colors: {
				"bg": Colors.colors.bg,
				"fg": Colors.colors.fg,
				"accent": Colors.colors.accent,
				"green": Colors.colors.green,
				"dim": Colors.colors.dim
			}

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
				
					Battery {}
					Network {}
					Volume {}
					Brightness {}
				}

				Rectangle {
					color: bar.colors["fg"]
					width: 2
					height: bar.barHeight - 10
					Layout.leftMargin: 10
					Layout.rightMargin: Layout.leftMargin
				}

				Clock {}
			}
		}
	}
}
