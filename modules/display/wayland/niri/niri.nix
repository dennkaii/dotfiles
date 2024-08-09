{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  cfg = config.display.niri;
in {
  options.display.niri = {
    enable = lib.mkEnableOption "niri";
  };
  config = lib.mkIf cfg.enable {
    inputs = {
      niri.url = "github:Sodiboo/niri-flake";
    };

    osModules = [inputs.niri.nixosModules.niri];
    # hmModules = [inputs.niri.homeModules.niri];

    os.nixpkgs.overlays = [inputs.niri.overlays.niri];

    os.programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
      settings = {
      };
    };
  };
}
