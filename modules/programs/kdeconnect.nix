{
  pkgs,
  config,
  lib,
  ...
}:let
cfg = config.programs.kde;
inherit(lib) mkEnableOption mkIf;
in {
  options.programs.kde.enable = mkEnableOption "kdeconnect";

  config = mkIf cfg.enable {
    os = {
      programs.kdeconnect.enable = true;
      
    };
  } ; 
}
