{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.superfile;
in {
  options.programs.superfile.enable = lib.mkEnableOption "superfile";

  config = lib.mkIf cfg.enable {
    inputs.superfile.url = "github:MHNightCat/superfile";

    hm.home.packages = [
      inputs.superfile.packages.${pkgs.hostPlatform.system}.default
    ];
  };
}
