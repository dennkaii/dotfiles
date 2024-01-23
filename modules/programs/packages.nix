#packages that i dont want to make a module for 
{
  pkgs,
  config,
  lib,
  ...
}:let

cfg = config.programs.packages;
inherit(lib) mkEnableOption mkIf;

in{
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
      home.packages = with pkgs;[
        obsidian
        libreoffice-qt

        floorp


        # webcord

        swaynotificationcenter

        rar
        # unrar

        gnome.nautilus

         #music no worky 
        tidal-hifi

        gimp-with-plugins

        krita


        bottles
        gamemode

        #for hyprland script
        socat
        jq
       ];
    };
  };
}

