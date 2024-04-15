{
  pkgs,
  config,
  lib,
  ...
}: let
  #might change name tbh
  cfg = config.programs.arduino;
in {
  options.programs.arduino.enable = lib.mkEnableOption "arduino";

  config = lib.mkIf cfg.enable {
    hm.home.packages = [
      pkgs.arduino
    ];
  };
}
