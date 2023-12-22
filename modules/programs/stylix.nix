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
  options.programs.stylix.enable = mkEnableOption "stylix";

  config = mkIf cfg.enable {
    inputs.stylix.url = "github:danth/stylix";

    hmModules = [ inputs.stylix.homeManagerModules.stylix ];

    hm = {
       stylix = {
         image = ../../wallpapers/wallapper_1.jpg;
        polarity = "dark";

        opacity = {
          terminal = 0.85;
        };

        base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-dark.yaml";

      };        
    };
  };
}
