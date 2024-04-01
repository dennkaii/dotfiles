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
  };

  config = mkIf cfg.enable {
    inputs.hyprpaper.url = "github:hyprwm/hyprpaper";

    hmModules = [inputs.hyprpaper.homeManagerModules.default];

    hm.services.hyprpaper = {
      enable = true;

      wallpapers = [
        "eDP-1,${config.wallpaper_dir}/moto_girl.png"
      ];
      preloads = [
        "${config.wallpaper_dir}/moto_girl.png"
      ];
    };
  };
}
