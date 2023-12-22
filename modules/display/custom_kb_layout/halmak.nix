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
      services.xserver.xkb.extraLayouts.halmak = {
        typesFile = "./types/complete"  ;
        keycodeFile = "./symbols/halmak";
      };
    };
    
  };
}
