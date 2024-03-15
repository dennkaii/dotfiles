{
  lib,
  config,
  ...
  }:let
cfg = config.programs.rio;
inherit(lib) mkEnableOption mkIf;
in {
  options.programs.rio.enable = mkEnableOption "rio Terminal";

  config = mkIf cfg.enable {
    hm.programs = {
      rio = {
        enable = true;
        settings = {
          
        };
      };
    };
  };
}
