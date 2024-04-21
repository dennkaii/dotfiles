{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.programs.qs;
  inherit (lib) mkIf mkEnableOption;
in {
  options.programs.qs.enable = mkEnableOption "quickshell(AGS replacement maybe????)";

  config = mkIf cfg.enable {
    inputs.qs = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hm.home.packages = [
      inputs.qs.packages.${pkgs.hostPlatform.system}.default
    ];
  };
}
