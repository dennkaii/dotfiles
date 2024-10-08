#packages that i dont want to make a module for
{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.packages;
  inherit (lib) mkEnableOption mkIf;
in {
  options.programs.packages = {
    enable = mkEnableOption "packages";
  };

  config = mkIf cfg.enable {
    #For obsian may remove later
    os = {
      nixpkgs.config.permittedInsecurePackages = [
        "electron-25.9.0"
        "electron-28.3.3"
        "electron-27.3.11"
        "freeimage-unstable-2021-11-01"
      ];

      services.gnome.sushi.enable = true;
    };

    hm = {
      home.packages = with pkgs; [
        # pipewire-pavucontrol
        # pwvucontrol
        # linux-wallpaperengine
        psmisc
        alsa-utils
        # fwupd

        libreoffice-qt

        flatpak
        gnome.gnome-software
        obsidian
        pavucontrol

        zig

        geogebra6
        clipse

        # copy poste??
        wl-clipboard
        stremio

        ani-cli

        vscodium

        foliate

        #for zig learnign???
        exercism

        btop

        way-displays

        beeper

        #Crashing too much
        # floorp

        #crashes everytime now???
        # nyxt

        qutebrowser
        # onionshare
        onionshare-gui

        element-desktop

        # cinny-desktop

        macchina

        rar

        kooha
        # unrar

        oculante

        nautilus

        tidal-hifi

        logseq

        zk

        #for hyprland script
        socat
        jq
      ];
    };
  };
}
