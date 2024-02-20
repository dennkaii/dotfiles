import { Widget } from "../../imports.js";

import { Workspaces } from "./buttons/workspaces.js";
import { Battery_progress } from "./buttons/battery.js";


const left_top =() => Widget.Box({
  orientation:1,
  vpack: "start",
  hpack:"center",
  child: Workspaces(),
})

const left_botttom = () => Widget.Box({
  orientation:1, 
  vpack: "end",
  
  child: Battery_progress(),
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
      center_widget: left_top(),
      end_widget: left_botttom(),
  }),
  });
