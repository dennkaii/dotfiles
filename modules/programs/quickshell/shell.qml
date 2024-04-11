import Quickshell
import Quickshell.Io
import QtQuick //text realted


ShellRoot{

      property string time;
    
    Variants{
        model: Quickshell.screens
                   PanelWindow{
                property var modelData
                screen: modelData
                
                anchors {
                top: true
                bottom: true
                left: true    
                }

                height:40

                Text {
                    anchors.centerIn: parent

                    text: time
                }
            }
       
    }

      Process {
    id: dateProc
    command: ["date"]
    running: true

    stdout: SplitParser {
      onRead: data => time = data
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: dateProc.running = true
  }
}
