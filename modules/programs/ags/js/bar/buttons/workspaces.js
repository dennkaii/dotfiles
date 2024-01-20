import { Hyprland, Widget, Utils } from "../../../imports.js";


const dispatch = arg => Utils.execAsync(`hyprctl dispacth workspace ${arg}`);


const workspaces = () => {
  // const ws = options.workspaces.value;
  return Widget.Box({
     children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Button({      attribute: i,
      on_clicked: () => dispatch(i),
      child: Widget.label({
        label: `${i}`,
        class_name: 'indicator',
        vpack: 'center',
        
      }),

      setup: self => self.hook(Hyprland, () => {
        self.toggleClassName('active', Hyprland.active.workspace.id == i);
        self.toggleClassName('occupied',(Hyprland.getWorkspace(i)?.windows || 0) > 0);
      }),
    })),
  })
};

export default () => Widget.EventBox({
  class_name: 'workspaces button',
  child: Widget.Box({
    child: Widget.EventBox({
        on_scroll_up: () => dispatch('m+1'),
            on_scroll_down: () => dispatch('m-1'),
            class_name: 'eventbox',
            child: workspaces(),
    })
  })
})



// const workspaces_redo = ( count = 10 ) => {
//   return Widget.Box
// }
