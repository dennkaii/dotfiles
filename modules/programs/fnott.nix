{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.fnott;
in {
  options.programs.fnott.enable = lib.mkEnableOption "fnott";

  config = lib.mkIf cfg.enable {
    hm.programs.fnott = {
      enable = true;
      settings = {
      };
    };
  };
}
