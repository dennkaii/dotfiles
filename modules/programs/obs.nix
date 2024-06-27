{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.obs;
  inherit (lib) mkEnableOption mkIf;
in {
  options.programs.obs.enable = mkEnableOption "obs";

  config = mkIf cfg.enable {
    hm = {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs; [
          obs-studio-plugins.wlrobs
          obs-studio-plugins.obs-vkcapture
          obs-studio-plugins.obs-vaapi
        ];
      };
    };
  };
}
