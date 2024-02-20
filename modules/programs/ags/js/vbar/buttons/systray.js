
const systemtray = await Service.import('systemtray');

export const sys_tray = () => Widget.Box({
    orientation:1,
    children: systemtray.bind('items').transform(items =>
        items.map(item => Widget.Button({
            child: Widget.Icon({ icon: item.bind('icon') }),
            on_primary_click: (_, event) => item.activate(event),
            on_secondary_click: (_, event) => item.openMenu(event),
            tooltip_markup: item.bind('tooltip_markup'),
        })),
    ),
});
