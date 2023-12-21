{
  lib,
  config,
  ...
}: let 
cfg = config.programs.foot;
inherit (lib) mkEnableOption mkIf;
in {
  options.programs.foot = {
    enable = mkEnableOption "foot";
  };

  config = mkIf cfg.enable {
    hm.programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          term = "foot";
          font-size-adjustment = "7.5%";
        };
        cursor = {
          style = "beam";
          blink = true;
        };

        mouse = {
          hide-when-typing = true;
        };

        colors = {
          alpha = 0.5;
        };
      };
    };
  };
}
