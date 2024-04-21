import Quickshell
import Quickshell.Io
import QtQuick //text realted


ShellRoot{

    
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

                height:10

                Text {
                    anchors.centerIn: parent

                    text: "aaaaa"
                }
            }
       
    }

}
