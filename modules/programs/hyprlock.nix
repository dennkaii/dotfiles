
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

    # hm.packages =[
    # inputs.hyprlock.${pkgs.hostPlatform.system}.default  
    # ];

    # hm.xdg.configFile."hypr/hyprlock.conf".text = ''
    # general {
    #   disbale_loading_bar = true
    # }
    # background {
    #   path =~/.nixConfig/wallpapers/lockwallpaper.png
    # }

    # input-field {
    #   placeholder_text = <b><i> Guess the pwd...</i></b>
    # }

    # label {
    #   text = $TIME
    # }

    # label {
    #   text = Who is $USER?
    # }
    # '';

    hmModules = [ inputs.hyprlock.homeManagerModules.default ];


    hm.programs.hyprlock = {
      enable = true;

      background = {
        path = "../../wallpapers/lockwallpaper.png";
        monitor = "";
      };

      # input_fields = {
      #   placeholder_text = "<i><b>Guess the pwd...</i></b>";
      # };

      # labels = {
      # text = "<b>$TIME</b>"; 
      # };

          };

    
    
  };
}
