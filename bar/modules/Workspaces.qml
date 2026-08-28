import Quickshell.Hyprland
import Quickshell
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: row
    //anchors.centerIn: parent
    spacing: 10

    Repeater {
        model: 9

        ColumnLayout {
            Layout.maximumWidth: 15

            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
            
            Text {
                id: wsNumber
                text: (index + 1)
                color: isActive ? bar.colors["fg"] : (ws ? bar.colors["accent"] : bar.colors["dim"])
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 1

                font {
                    family: "JetBrainsMono Nerd Font Regular"
                    pixelSize: 14
                    weight: isActive ? 700 : 400
                }
            }

            Rectangle {
                visible: isActive
                Layout.topMargin: -8
                height: 2.5
                color: wsNumber.color

                Layout.fillWidth: true
                opacity: isActive ? 1 : 0
                Behavior on opacity {
                    PropertyAnimation { duration: 200 }
                }
            }
        }
    }
}
