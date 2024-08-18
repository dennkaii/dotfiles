# My Nixos Flake

This flake contains my hosts, configs and modules.

## structure

```
Dennkaii/
├───hosts/          (machine specific configuration)
│   └───Aethyr/           [Main machine]
│
├───configs/          (machine specific configuration)
│   └───dennkaii/           [Main machine]
│
├───modules/        (custom modules you can enable under `myOptions`)
│   ├───display/         (Window managers configurations + fcitx)
│   ├───programs/        (Modules for programs i use, wanted to or just tried one time, also games)
│   ├───misc/        (Configuration of things that should alway be working no 'mkIf' modules)
│   └───services/         (where i have docker, podman, tailscale, may merge with programs)
│
├───Wallpapes/        (Literally my wallpaper collection)
│
└───secrets/        (agenix secrets)
```

