import {SystemTray as systray, Widget as widget  } from "../../../imports.js" ;

const systrayitem = item => widget.button({
  child: widget.Icon().bind('icon', item , 'icon'),
  tooltipMarkup: item.bind('tooltip-markup'),
  onPrimaryClick: (_, Event) => item.active(Event),
  onSecondaryClick: (_, Event) => item.openMenu(Event),
});


export default () => widget.box()
  .bind('children', systray, 'items', i => i.map(systrayitem))
  
