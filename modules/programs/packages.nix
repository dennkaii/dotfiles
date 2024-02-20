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

        webcord

        floorp

        swaynotificationcenter

        #audio purpouses but i remmeber havinf it installed
        pavucontrol

        

        #fetch
        macchina

        rar

        kooha
        # unrar

        vesktop

        gnome.nautilus

         #music no worky 
        tidal-hifi

        gimp-with-plugins

        krita

        logseq


        bottles
        gamemode

        #for hyprland script
        socat
        jq
       ];
    };
  };
}

