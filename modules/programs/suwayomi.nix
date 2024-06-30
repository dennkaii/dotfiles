{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.gui.suwayomi;
in {
  options.programs.gui.suwayomi.enable = lib.mkEnableOption "Desktop manga/manwha reader";

  config = lib.mkIf cfg.enable {
    os.services.suwayomi-server = {
      enable = true;
    };
  };
}
