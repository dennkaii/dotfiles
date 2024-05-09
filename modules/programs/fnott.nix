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
    hm.services.fnott = {
      enable = true;
      settings = {
        main = {
          max-height = 200;
          notification-margin = 5;
          stacking-order = "top-down";
          anchor = "bottom-right";
          layer = "overlay";

          max-timeout = 15;
          default-timeout = 7;
        };
      };
    };
  };
}
