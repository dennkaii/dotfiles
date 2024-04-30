{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.fuzzel;
in {
  options.programs.fuzzel.enable = lib.mkEanbleOption "fuzzel";

  config = lib.mkIf cfg.enable {
    hm.programs = {
      fuzzel = {
        enable = true;
        settings = {
        };
      };
    };
  };
}
