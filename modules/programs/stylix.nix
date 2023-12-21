{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:let
cfg = config.programs.stylix;
inherit(lib) mkIf mkEnableOption;
in {
  options.programs.stylix = mkEnableOption "stylix";

  config = mkIf cfg.enable {
    inputs.stylix.url = "github:danth/stylix";

    hmModules = [ inputs.stylix.homeManagerModules.stylix ];

    hm = {
      wallpaper = config.lib.stylix.mkAnimation {
      animation = "../../wallpapers/wallaper_1.jpg";
        polarity = "dark";
        
      };
    };
  };
}
