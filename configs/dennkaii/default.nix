{config, ...}: {
  users.main = "dennkaii";

  wallpaper_dir = "/home/${config.users.main}/.nixConfig/wallpapers";

  display = {
    hyprland.enable = true;
    sddm.enable = false;
    fcitx.enable = true;
  };

  fonts.enable = true;

  gtk.enable = true;

  #virtualmachine bs
  vm.enable = true;

  programs = {
    packages.enable = true;

    qs.enable = true;

    anyrun.enable = true;
    walker.enable = true;
    git.enable = true;

    # the nix pkgs ver is outdated and i dont see how to fetch it to make it?
    radicle.enable = false;

    schizofox.enable = true;
    uchromium.enable = true;

    neovim.enable = false;

    # Not worky
    discord.enable = true;

    hyprlock.enable = true;
    hypridle.enable = true;
    hyprpaper.enable = true;

    rbw.enable = true;

    ags.enable = true;
    waybar.enable = false;
    kde.enable = true;

    starship.enable = true;

    mako.enable = true;
    obs.enable = false;

    fish.enable = false;

    nu.enable = true;

    foot.enable = true;
    tmux.enable = true;

    stylix.enable = true;

    games = {
      osu-lazer.enable = true;
      steam.enable = true;
      minecraft.enable = true;
      lutris.enable = true;
    };
  };

  services = {
    ssh.enable = true;
    tailscale.enable = false;
    protonvpn.enable = true;

    podman.enable = true;
    docker.enable = true;
  };
}
