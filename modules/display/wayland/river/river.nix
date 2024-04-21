{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.display.river;
in {
  options.display.river.enable = lib.mkEnableOption "river wm";
  config = lib.mkIf cfg.enable {
    os.programs.river = {
      enable = true;
      extraPackages = with pkgs; [
      ];
    };
    hm.wayland.window.Manager.river = {
      enable = true;
      xwayland.enable = true;
      settings = {
        border-width = 2;
        declare-mode = [
          "locked"
          "normal"
        ];
        map = {
          normal = {
            "Super+Shift Q" = "close";
            "Super Return" = "spawm foot";
            "Super SPACE" = "spawn walker";
            "Super+Shift E" = "exit";
          };
        };
      };
    };
  };
}
