{
  config,
  pkgs,
  ...
}: {
  users.main = "dennkaii";

  # need to migrate it to defaults
  wallpaper_dir = "${toString config.defaults.flake_dir}/wallpapers/sekirowall.png";

  defaults = {
    terminal = "wezterm";
    cursor = {
      name = "Breeze_Snow";
      size = 24;
      pkg = pkgs.kdePackages.breeze;
    };
  };

  display = {
    # hyprland.enable = true;
    river.enable = true;
    #not used anymore
    # sddm.enable = true;
    # for 한굴
    fcitx.enable = true;
    niri.enable = true;
  };

  fonts.enable = true;

  gtk.enable = true;

  #virtualmachine bs
  vm.enable = true;

  programs = {
    _1password.enable = true;
    # packages i was lazy to make a module for
    packages.enable = true;
    #Wigets
    qs.enable = true;
    #Launcher and notification daemon
    fuzzel.enable = true;
    fnott.enable = true;
    #Git
    git.enable = true;
    radicle.enable = true;
    #Idr now
    prism.enable = false;
    # browser
    uchromium.enable = true;
    # terminal file manager with alot of funny things
    superfile.enable = true;
    #Vesktop discord
    discord.enable = false;
    #Wallpapaer, lockscreen and idle daemon
    hyprlock.enable = true;
    hypridle.enable = true;
    hyprpaper.enable = false;
    # Not Being used
    ags.enable = false;
    waybar.enable = true;
    # kdeConnect
    kde.enable = false;
    #Terminal prompt theming
    ompsh.enable = true;
    #Recording
    obs.enable = false;
    #Default shell
    nu.enable = true;
    #browser
    schizofox.enable = true;
    # Foot terminal but seems broken
    terminals = {
      wezterm.enable = true;
      foot.enable = false;
    };
    gui = {
      #manga reader
      suwayomi.enable = false;
    };
    #terminal multiplexer but plugins no worky
    tmux.enable = false;
    #define fonts and global theme
    stylix.enable = true;
    # literal games
    games = {
      osu-lazer.enable = true;
      steam.enable = true;
      minecraft.enable = false;
      lutris.enable = true;
    };

    # DISABLED FOREVER PROBABLY
    mako.enable = false;
    fish.enable = false;
    rbw.enable = true;
    neovim.enable = false;
    anyrun.enable = false;
    arduino.enable = false;
    #Migrated to ompsh
    starship.enable = false;
  };

  services = {
    ssh.enable = true;
    tailscale.enable = false;
    protonvpn.enable = false;
    podman.enable = false;

    searxng.enable = false;
  };
}
