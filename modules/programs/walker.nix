
{pkgs,
config,
lib,
inputs,
...}: let
  cfg = config.programs.walker;
  inherit(lib) mkIf mkEnableOption;
  in {
    options.programs.walker.enable = mkEnableOption "anyrun replacement";

    config = mkIf cfg.enable{
      inputs.walker.url = "github:abenz1267/walker";

      hm.home.packages = [
        inputs.walker.packages.${pkgs.hostPlatform.system}.default
      ];
    };
  }
