{config, ...}: {
  users.main = "dennkaii";

  wallpaper_dir = "/home/${config.users.main}/.nixConfig/wallpapers/sekirowall.png";

  defaults = {
    terminal = "wezterm";
  };

  display = {
    # hyprland.enable = true;
    river.enable = true;
    #not used anymore
    sddm.enable = false;
    # for 한굴
    fcitx.enable = true;
  };

  fonts.enable = true;

  gtk.enable = true;

  #virtualmachine bs
  vm.enable = true;

  programs = {
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
    hyprpaper.enable = true;
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
    # Foot terminal but seems broken
    foot.enable = false; #wezterm need to move foot inside
    terminals = {
      wezterm.enable = true;
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
    schizofox.enable = true;
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

    searxng.enable = true;
  };
}
