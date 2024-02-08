{
  config,
  lib,
  pkgs,
  ...
}: let
cfg = config.display.fcitx;

inherit(lib) mkEnableOption mkIf;

in {
  options.display.fcitx.enable = mkEnableOption "fcitx";

  config = mkIf cfg.enable {
      os = {
      i18n.inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; [
          fcitx5-hangul
        ];
      };    
    };
  };
}
