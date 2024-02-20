import { Hyprland } from "../../../imports.js";
import { Widget } from "../../../imports.js";
export const Workspaces = () =>
  Widget.Box({
    class_name: "workspaces",
    child: Widget.Box({
      orientation: 1,
      children: Array.from({ length: 10 }, (_, i) => i + 1).map((i) =>
        Widget.Button({
          cursor: "pointer",
          attribute: { index: i },
          on_clicked: () =>
            Utils.execAsync(["hyprctl", "dispatch", "workspace", `${i}`]).catch(
              console.error,
            ),
          on_secondary_click: () =>
            Utils.execAsync([
              "hyprctl",
              "dispatch",
              "movetoworkspacesilent",
              `${i}`,
            ]).catch(console.error),
        }),
      ),
      setup: (self) => {
        self.hook(Hyprland, (self) =>
          self.children.forEach((btn) => {
            btn.class_name =
              btn.attribute.index === Hyprland.active.workspace.id
                ? "focused"
                : "";
            btn.visible = Hyprland.workspaces.some(
              (ws) => ws.id === btn.attribute.index,
            );
            /*btn.label =
								btn._index === Hyprland.active.workspace.id ? "󰣐" : "󱢠";*/
          }),
        );
      },
    }),
  });
