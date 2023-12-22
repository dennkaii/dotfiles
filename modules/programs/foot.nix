{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let 
cfg = config.programs.foot;
inherit (lib) mkEnableOption mkIf;
in {
  options.programs.foot = {
    enable = mkEnableOption "foot";
  };

  config = mkIf cfg.enable {
  inputs.nyxpkgs.url = "github:notashelf/nyxpkgs";
  
    hm.programs.foot = {
      enable = true;
      server.enable = true;
      package = inputs.nyxpkgs.packages.${pkgs.hostPlatform.system}.foot-transparent;
      
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

        # colors = {
        #   alpha = 0.2;
        # };
      };
    };
  };
}
