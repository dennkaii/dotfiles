
{
  lib,
  inputs,
  pkgs,
  config,
  ...
}:let
cfg = config.programs.hyprlock;
inherit(lib) mkEnableOption mkIf;

 in {
  options.programs.hyprlock.enable = mkEnableOption "hyprlock";

  config = mkIf cfg.enable{
    inputs.hyprlock.url = "github:hyprwm/hyprlock";

    hmModules = [ inputs.hyprlock.homeManagerModules.default ];


    hm.programs.hyprlock = {
      enable = true;

      general.hide_cursor = false;

      backgrounds = [
       {
      # path = "/home/dennkaii/.nixConfig/wallpapers/lockwallpaper.png";
        monitor = "";
        color = "rgba(25, 20, 20, 1.0)";
        blur_size = 10;
        blur_passes = 4;
        noise = 0.03;
        contrast = 1.0;
        
        }
      ];

      input-fields = [
        {
          monitor = "eDP-1";

          # placeholder_text = "<b>Do you know me?</b>";
          dots_center = true;
          dots_spacing  = 0.3;
          fade_on_empty = true;
        }
      ];

      labels = [
        {
          monitor = "";
          text = "$TIME";

          position = {
            x = 0;
            y =  100;
          };

          valign = "center";
          halign = "center";
        }
        ];

      # input_fields = {
      #   placeholder_text = "<i><b>Guess the pwd...</i></b>";
      # };

      # labels = {
      # text = "<b>$TIME</b>"; 
      # };

          };

    
    
  };
}
