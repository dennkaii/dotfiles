{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.fuzzel;
in {
  options.programs.fuzzel.enable = lib.mkEnableOption "fuzzel";

  config = lib.mkIf cfg.enable {
    hm.programs = {
      fuzzel = {
        enable = true;
        settings = lib.mkForce {
          main = {
            terminal = "${pkgs.foot}/bin/foot";
            layer = "overlay";
            lines = 10;
            width = 20;
            horizontal-pad = "15";
            font = "Liga SFMono Nerd:size=9";
          };
          colors = {
            background = "161616ff";
            text = "ffffffff";
            match = "ff7eb6ff";
            selection = "393939ff";
            selection-text = "ee5396ff";
            selection-match = "82cfffff";
            border = "262626ff";
          };
        };
      };
    };
  };
}
