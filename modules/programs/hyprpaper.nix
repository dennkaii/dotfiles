{
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.programs.hyprpaper;
  inherit (lib) mkEnableOption mkIf;
in {
  options = {
    programs.hyprpaper.enable = mkEnableOption "hyprpaper";

    wallpaper_dir = lib.mkOption {
      type = with lib.types; str;
      description = ''
        Wallpapaer path
      '';
    };
    wallName =
      lib.mkOption {
      };
  };

  config = mkIf cfg.enable {
    inputs.hyprpaper.url = "github:hyprwm/hyprpaper";

    # hmModules = [inputs.hyprpaper.homeManagerModules.default];

    hm.services.hyprpaper = {
      enable = true;

      settings = {
        wallpaper = [
          "eDP-1,${config.wallpaper_dir}"
        ];
        preload = [
          "${config.wallpaper_dir}"
        ];
      };
    };
  };
}
