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
  };

    hm = {
      home.packages = with pkgs;[
        obsidian
        libreoffice-qt


        webcord

        rar
        unrar



         #music no worky 
        tidal-hifi

        #for hyprland script
        socat
        jq
       ];
    };
  };
}

