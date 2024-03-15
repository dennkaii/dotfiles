{
  config,
  lib,
  inputs,
  ...
}:let
cfg = config.programs.hypridle;
inherit(lib) mkEnableOption mkIf;
in {
  options.programs.hypridle.enable = mkEnableOption "hypridle";

  config = mkIf cfg.enable {
    inputs.hypridle.url = "github:hyprwm/hypridle";

    hmModules = [inputs.hypridle.homeManagerModules.default];

    hm.services.hypridle = {

    lockCmd = "pidof hyprlock || hyprlock";
    afterSleepCmd = "hyprctl dispatch dpms on";
    beforeSleepCmd = "loginctl lock-session";
    
      listeners = [
        {
          timeout = 500;
          onTimeout = "loginctl lock-session";
        }
        {
          timeout = 530;
          onTimeout = "hyprctl dispatch dpms off";
          onResume = "hyprctl dispatch dpms on ";
          
        }
        {
          timeout = 1800;
          onTimeout = "systemctl suspend";
        }
      ];    };
  };
}
