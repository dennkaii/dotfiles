#bitearden unofficial client
{
  pkgs,
  config,
  lib,
  ...
}: let 
cfg = config.programs.rbw;
inherit(lib) mkEnableOption mkIf;
in {
  optons.programs.rbw.enable = mkEnableOption "rbw";

  config = mkIf cfg.enable {
    hm.programs.rbw = {
      enable = true;
      
    };
  };
}
