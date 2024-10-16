const battery = await Service.import("battery");
const audio = await Service.import("audio");
const date = Variable("", {
  poll: [1000, 'date "+%H:%M:%S %b %e."'],
});

function Clock() {
  return Widget.Label({
    class_name: "clock",
    label: date.bind(),
  });
}

function BatteryLabel() {
  const value = battery.bind("percent").as((p) => (p > 0 ? p / 100 : 0));
  const icon = battery
    .bind("percent")
    .as((p) => `battery-level-${Math.floor(p / 10) * 10}-symbolic`);

  return Widget.Box({
    class_name: "battery",
    visible: battery.bind("available"),
    children: [
      Widget.Icon({ icon }),
      Widget.LevelBar({
        widthRequest: 140,
        vpack: "center",
        value,
      }), ], });
}

function Volume() {
  const icons = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
  };

  function getIcon() {
    const icon = audio.speaker.is_muted
      ? 0
      : [101, 67, 34, 1, 0].find(
        (threshold) => threshold <= audio.speaker.volume * 100,
      );

    return `audio-volume-${icons[icon]}-symbolic`;
  }

  const icon = Widget.Icon({
    icon: Utils.watch(getIcon(), audio.speaker, getIcon),
  });

  const slider = Widget.Slider({
    hexpand: true,
    draw_value: false,
    on_change: ({ value }) => (audio.speaker.volume = value),
    setup: (self) =>
      self.hook(audio.speaker, () => {
        self.value = audio.speaker.volume || 0;
      }),
  });

  return Widget.Box({
    class_name: "volume",
    css: "min-width: 180px",
    children: [icon, slider],
  });
}

function Left() {
  return Widget.Box({
    hpack: "start",
    children: [],
  });
}

function Center() {
  return Widget.Box({
    children: [Clock()],
  });
}

function Right() {
  return Widget.Box({
    hpack: "end",
    children: [Volume(), BatteryLabel()],
  });
}

function Bar(monitor = 0) {
  return Widget.Window({
    monitor,
    name: `bar${monitor}`, // this name has to be unique
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(),
      end_widget: Right(),
    }),
  });
}

// TODO: edit the module to allow for multiple monitors in the nix config
App.config({
  style: "./style.css",
  windows: [Bar()],
});
