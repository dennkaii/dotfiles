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
        settings = {
          main = {
            terminal = "${pkgs.foot}/bin/foot";
            layer = "overlay";
            lines = 10;
            width = 25;
            horizontal-pad = "30";
          };
          colors = {
            background = "161616";
            text = "ffffff";
            match = "ff7eb6";
            selection = "393939";
            selection-text = "ee5396";
            selection-match = "82cfff";
            border = "393939";
          };
        };
      };
    };
  };
}
