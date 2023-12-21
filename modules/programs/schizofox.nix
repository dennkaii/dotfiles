{
  lib,
  inputs,
  config,
  ...
}: let
cfg = config.programs.schizofox;
inherit (lib) mkEnableOption mkIf;
in {
  options.programs.schizofox = {
    enable = mkEnableOption "schizofox";
  };

  config = mkIf cfg.enable {
    inputs = {schizofox.url = "github:schizofox/schizofox"; };

    hmModules = [inputs.schizofox.homeManagerModules.default];    

    hm = {
    #TODO declarative config
    programs.schizofox = {
      enable = true;
      };
    };
  };
}
