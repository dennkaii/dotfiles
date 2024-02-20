const battery = await Service.import('battery');

export const Battery_progress = () => Widget.CircularProgress({
  value: battery.bind('percent').transform(p => p/ 100),
  start_at: 0.75,
  child: Widget.Icon({
     icon: battery.bind('percent').transform(p =>
                `battery-level-${Math.floor(p / 10) * 10}-symbolic`, ), }),
})



