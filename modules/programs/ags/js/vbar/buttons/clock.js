import { Widget } from "../../../imports.js";
import { Utils } from "../../../imports.js";


export default () =>
  Widget.EventBox({
    child: Widget.Label({className: "date_Module"})
    .poll(
      1000,
      (self) =>
      Utils.execAsync(["date", "+%H\n%M"]).then((r) => self.label = r),
    ),
  });

