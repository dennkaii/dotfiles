{
  config,
  pkgs,
  lib,
  ...
}:let
cfg = config.display.layout;
inherit(lib) mkIf mkEnableOption;
in {
  options.display.layout = {
    enable = mkEnableOption "layout";
  };

  config = mkIf cfg.enable {
    os = {

    services.xserver.xkb = {
      layout = "halmak";
    };
      services.xserver.xkb.extraLayouts.halmak = {
      description = "halmak keyboard layout";

        typesFile = ./types/complete ;
        keycodesFile = ./symbols/halmak;
        languages = [
          "eng"
        ];
      };
    };
    
  };
}
