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
      ];

      services.gnome.sushi.enable = true;
    };

    hm = {
      home.packages = with pkgs; [
        libreoffice-qt

        zig

        ani-cli

        #for zig learnign???
        exercism

        # pueue
        btop

        # premid

        ferdium # webcord

        upscayl
        way-displays

        # gnome2.libgnome
        # gnome.gnome-software

        beeper

        floorp

        obs-studio
        # gnome.gnome-boxes

        #crashes everytime now???
        # nyxt

        qutebrowser

        #audio purpouses but i remmeber havinf it installed
        pavucontrol

        tldr

        element-desktop

        protonmail-desktop
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
