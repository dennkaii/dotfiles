import { Widget } from "../../imports.js";

import { Workspaces } from "./buttons/workspaces.js";
import { Battery_progress } from "./buttons/battery.js";
import { sys_tray } from "./buttons/systray.js";

const left_center =() => Widget.Box({
  orientation:1,
  vpack: "start",
  hpack:"center",
  child: Workspaces(),
})

const left_botttom = () => Widget.Box({
  orientation:1, 
  vpack: "end",
  hpack: "center",
  
  children:[ 
    Battery_progress(),
    sys_tray()]
})

export const vbar = () => 
  Widget.Window({
    name: "vbar",
    anchor: ["left", "top", "bottom"],
    exclusivity: "exclusive",
    layer: "top",
    child: Widget.CenterBox({
      class_name:"var",
      orientation: 1,
      spacing: 100,
      start_widget: Widget.Label("aaaaaaa"),
      center_widget: left_center(),
      end_widget: left_botttom(),
  }),
  });
