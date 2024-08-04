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
      ];

      services.gnome.sushi.enable = true;
    };

    hm = {
      home.packages = with pkgs; [
        libreoffice-qt

        flatpak
        gnome.gnome-software
        obsidian

        zig
        kdenlive

        inkscape

        geogebra6

        ani-cli

        vscodium

        foliate

        #for zig learnign???
        exercism

        btop

        upscayl
        way-displays

        beeper

        floorp

        #crashes everytime now???
        # nyxt

        qutebrowser

        #audio purpouses but i remmeber havinf it installed
        pavucontrol

        # onionshare
        onionshare-gui

        element-desktop

        # cinny-desktop

        macchina

        rar

        kooha
        # unrar

        oculante

        gnome.nautilus

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
