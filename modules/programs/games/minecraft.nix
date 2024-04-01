{pkgs,
lib,
config,
...}: let

cfg = config.programs.games.minecraft;

jdks = with pkgs; [
    # Java 8
    temurin-jre-bin-8
    zulu8

    # Java 11
    temurin-jre-bin-11

    # Java 17
    temurin-jre-bin-17

    # Latest
    temurin-jre-bin
    zulu
    graalvm-ce
  ];

  additionalPrograms = with pkgs; [
    gamemode
    mangohud
    # jprofiler
  ];

  glfw = pkgs.glfw-wayland-minecraft;

  in {
    options.programs.games.minecraft.enable = lib.mkEnableOption "minectaft";

    config = lib.mkIf cfg.enable {
      hm.home.packages = [
        (pkgs.prismlauncher.override{
          inherit jdks;
          inherit additionalPrograms;
          inherit glfw;
        })
      ];
    };
  }  
