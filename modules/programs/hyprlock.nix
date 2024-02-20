
{
  lib,
  inputs,
  config,
  ...
}:let
cfg = config.programs.hyprlock;
inherit(lib) mkEnableOption mkIf;

 in {
  options.programs.hyprlock.enable = mkEnableOption "hyprlock";

  config = mkIf cfg.enable{
    inputs.hyprlock.url = "github:hyprwm/hyprlock/blob/fonts";

    hmModules = [ inputs.hyprlock.homeManagerModules.hyprlock ];


    hm.hyprlock = {
      enable = true;

      backgrounds = {
        path = "../../wallpapers/lockwallpaper.png";
        monitor = "";
      };

      input_field = {
        placeholder_text = "<i><b>Guess the psw...</i></b>";
      };

      label = {
        text = "<b$TIME</b>/nHello $USER";
      };

      
    };

    
    
  };
}
