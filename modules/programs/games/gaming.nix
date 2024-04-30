{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.programs.games;
  inherit (lib) mkIf mkEnableOption;
in {
  options.programs.games = {
    steam.enable = mkEnableOption "steam";
    lutris.enable = mkEnableOption "lutris";
  };

  config.os = lib.mkMerge [
    (mkIf cfg.steam.enable {
      programs.steam = {
        enable = true;

        package = pkgs.steam.override {
          extraPkgs = pkgs:
            with pkgs; [
              keyutils
              libkrb5
              libpng
              libpulseaudio
              libvorbis
              stdenv.cc.cc.lib
              xorg.libXcursor
              xorg.libXi
              xorg.libXinerama
              xorg.libXScrnSaver
            ];
        };
      };

      programs.gamescope.enable = true;
    })
    (mkIf cfg.lutris.enable {
      environment.systemPackages = with pkgs; [
        (lutris.override {
          extraPkgs = pkgs: [
            #Gamescope things
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama

            xorg.libXScrnSaver
            jansson
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
            inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge

            gamemode
            winetricks
            wineWowPackages.full
            wine64Packages.full
          ];
        })
      ];
    })
  ];
}
