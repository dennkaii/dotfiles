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
      settings = {
        main = {
          term = "foot";
        };
      };
    };
  };
}
