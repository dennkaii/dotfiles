{
  lib,
  config,
  inputs,
  ...
}:let
cfg = config.programs.ags;
inherit (lib) mkEnableOption mkIf;

in {
  options.programs.ags = {
    enable = mkEnableOption "ags";
  };

  config = mkIf cfg.enable {
    inputs.ags.url = "github:Aylur/ags";

    hmModules = [inputs.ags.homeManagerModules.default];

    hm = {
      programs.ags = {
        enable = true;
        configDir = ../ags ;
        
      };
    };
  };
}
