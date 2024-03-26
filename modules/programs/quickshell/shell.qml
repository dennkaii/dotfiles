import Quickshell
import QtQuick

ShellRoot {
    PanelWindow {
            anchors {
            top: true
            left: true
            right: true
            }
        height: 30

        Text {
            anchors.centerIn: parent
            text: "testing"
        }
    }
}
