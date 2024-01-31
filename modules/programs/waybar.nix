{
  pkgs,
  lib,
  config,
  ...
}: let
cfg = config.programs.waybar;
inherit(lib) mkIf mkEnableOption;
in {
  options.programs.waybar.enable = mkEnableOption "waybar";

  config = mkIf cfg.enable{

  hm = {

  
    programs.waybar = {
      enable = true;

      settings = {

      mainBar = {
        layer = "top";
        position = "bottom";
        height = 15;

        modules-center = ["hyprland/workspaces"];


        "hyprland/workspaces" = {
          # active-only = true;

          format = "{icon}";

          format-icons = {
              active = "";
              empty = "";
              default = "";
          };

          persistent-workspaces = {
            "*" = 5;
          };
                  
        };
      };
      
            };


            style = ''
              * {
                border: none;
    border-radius: 16px;
    font-family: "Torus Nerd Font";
    font-size: 16px;
    min-height: 0;
              }


              #workspaces button {
                padding: 0.5rem;
                margin: 0.25rem;
                background-color:@base02;
                color: @base10;
              }


              #workspaces button.empty {
                 color: @base09;
               }
            '';

     
      };
    };
  };
}
