#bitearden unofficial client
{
  config,
  lib,
  ...
}: let 
cfg = config.programs.rbw;
inherit(lib) mkEnableOption mkIf;
in {
  options.programs.rbw.enable = mkEnableOption "rbw";

  config = mkIf cfg.enable {
    hm.programs.rbw = {
      enable = true;
      settings = {
        email = "sperezvargas508@gmail.com";
        pinentry = "gnome3";
      };
      
    };
  };
}
