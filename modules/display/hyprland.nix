{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  cfg = config.display.hyprland;
  inherit (lib) mkEnableOption mkOption mkIf mkMerge types mapAttrsToList;
 in {
  options.display.hyprland = {
    enable = mkEnableOption "hyprland";
  };

  config = mkMerge [
    {
      inputs = {
      
        hyprland.url = "github:hyprwm/hyprland";
        hyprland.inputs.nixpkgs.follows = "nixpkgs";

         hyprcontrib = {
          url = "github:hyprwm/contrib";
          inputs.nixpkgs.follows = "nixpkgs";
          };
          
      };
    }

    (mkIf cfg.enable {
    
      os = {
        programs.hyprland = {
          enable = true;
        };

         xdg.portal = {
            enable = true;
            extraPortals = [pkgs.xdg-desktop-portal-gtk];
          };  
      };

      hm = {

      home.packages = with pkgs;[
        swww
      ];
      
        wayland.windowManager.hyprland = {
          enable = true;
          xwayland.enable = true;
          package = inputs.hyprland.packages.${pkgs.system}.hyprland;

          settings = let
            swww = "${pkgs.swww}/bin/swww";
            playerctl = "${pkgs.playerctl}/bin/playerctl";
            pactl = "${pkgs.pulseaudio}/bin/pactl";
            pamixer = "${pkgs.pamixer}/bin/pamixer";
          in {
             env = mapAttrsToList (name: value: "${name},${toString value}") {
              XCURSOR_SIZE = 24;
              GDK_SCALE = 1.3;
              WLR_DRM_NO_ATOMIC = 1;
              XDG_SESION_TYPE = "wayland";
              GDK_BACKEND = "wayland";
              TERM = "foot";
              NIXOS_OZONE_WL = "1";
            };

            monitor = [
              "eDP-1,highres, auto, 1.3"
            ];

            exec-once = [
              # "${pkgs.foot}/bin/foot --server"
              
              "${swww} init &"
              "foot --server"
              "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store #Stores only text data"
              "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store #Stores only image data"
              "./scripts/dynamic-borders.sh"
              #wait a bit
              "sleep 3"

              "${swww} img ${../../wallpapers/6window_V2.jpg}"
            ];

            general = {
              gaps_in = 1;
              gaps_out = 2;
              border_size = 1;
              
              allow_tearing = true;

              layout = "dwindle";
               # "col.active_border" =  "rgba(33ccffee) rgba(00ff99ee) 45deg";
              
            };

            binds = {
              workspace_back_and_forth = true;
              allow_workspace_cycles = true;
            };
            xwayland = {
              force_zero_scaling = true;
            };

            decoration = {
              rounding = 1;
              drop_shadow = true;
              shadow_range = 5;
              shadow_render_power = 2;
               # "col.shadow" = "rgba(00000044)";
              # shadow_offset = "0 0";
              blur = {
                enabled = true;
                size = 5;
                passes = 4;
                ignore_opacity = true;
                # xray = true;
                new_optimizations = true;
                # noise = 0.03;
                # contrast = 1.0;
                };
            };
            
            dwindle = {
              pseudotile = 0;
              force_split = 2;
              preserve_split = 1;
              default_split_ratio = 1.3;
            };
            
            master = {
              new_is_master = false;
              new_on_top = false;
              no_gaps_when_only = false;
              orientation = "top";
              mfact = 0.6;
              always_center_master = false;
            };


            animation = {
              bezier = [
#               "smoothOut, 0.36, 0, 0.66, -0.56"
#               "smoothIn, 0.25, 1, 0.5, 1"
#               "overshot, 0.4, 0.8, 0.2, 1.2" 

              "fluent_decel, 0, 0.2, 0.4, 1"
              " easeOutCirc, 0, 0.55, 0.45, 1"
              "easeOutCubic, 0.33, 1, 0.68, 1"
              "easeinoutsine, 0.37, 0, 0.63, 1"
              ];

              animation = [
               #window opem
                "windowsIn, 1, 3, easeOutCubic, popin 30%" 

                # window close
                "windowsOut, 1, 3, fluent_decel, popin 70%"
                #window moving,draggin,etc
                "windowsMove, 1, 2, easeinoutsine, slide"
                #fade in open -> layers and windows
                "fadeIn, 1, 3, easeOutCubic"
                 # fade out (close) -> layers and windows
                "fadeOut, 1, 1.7, easeOutCubic"
                #face on changin active window and opacity
                "fadeSwitch, 0, 1, easeOutCirc"
                "fadeShadow, 1, 10, easeOutCirc" # fade on changing activewindow for shadows
                "fadeDim, 1, 4, fluent_decel" # the easing of the dimming of inactive windows
                "border, 1, 2.7, easeOutCirc" # for animating the border's color switch speed
                "borderangle, 1, 30, fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
                "workspaces, 1, 3, easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
                #STOLEN FROM :https://discord.com/channels/961691461554950145/1162860692978794627 
              ];
            };

            input = {
              follow_mouse = 1;
              force_no_accel = 1;
              kb_layout = "us";
              sensitivity = 0.5;

              touchpad = {
                natural_scroll = 0;
              };
            };

            misc = {
              disable_autoreload = true;
              
              enable_swallow = true; # hide windows that spawn other windows
              swallow_regex = "foot|footclient"; # windows for which swallow is applied

              disable_splash_rendering = true;
              mouse_move_enables_dpms = true;
              key_press_enables_dpms =  true;
              disable_hyprland_logo = true;
            };

            "$mod"="SUPER";
            bind = [
              #Programs related
              "$mod, space, exec, anyrun  "
              "$mod, return, exec, footclient"


              #windows managment related
              "$mod, C, killactive,"
              "$mod, SEMICOLON, exit,"
              "$mod, V, togglefloating,"
              "$mod, P, pseudo, # dwindle"
              "$mod, J, togglesplit, # dwindle"
              "$mod, S, fullscreen,"
              "$mod,Tab,cyclenext,  "        # change focus to another window
              "$mod,Tab,bringactivetotop,"   # bring it to the top

              ",XF86AudioPlay,exec,${playerctl} play-pause"
              ",XF86AudioPrev,exec,${playerctl} previous"
              ",XF86AudioNext,exec,${playerctl} next"

              # WORKSPACE MOVEMENT
              "${builtins.concatStringsSep "\n" (builtins.genList (
                  x: let
                  ws = let
                  c = (x + 1) / 10;
                    in
              builtins.toString (x + 1 - (c * 10)); 
              in
              '' 
              bind = $mod, ${ws}, workspace, ${toString (x +1)}
              bind = $modSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
              '')
              10)}"

              #change focus keys
              "$mod, left, movefocus, h"
              "$mod, right, movefocus, l"
              "$mod, up, movefocus, k"
              "$mod, down, movefocus, j"



              #resize submad prolly
              
            ];
            binde = [
            ",XF86AudioRaiseVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ +5% && ${pactl} get-sink-volume @DEFAULT_SINK@ | head -n 1 | awk '{print substr($5, 1, length($5)-1)}' > $WOBSOCK"
            ",XF86AudioLowerVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ -5% && ${pactl} get-sink-volume @DEFAULT_SINK@ | head -n 1 | awk '{print substr($5, 1, length($5)-1)}' > $WOBSOCK"
            ];

            bindm = [
              "$mod,mouse:272,movewindow"
              "$mod,mouse:273,resizewindow"
            ];
            
            windowrule = [
              "center,^(leagueclientux.exe)$"
              "center,^(league of legends.exe)$"
              "forceinput,^(league of legends.exe)$"
              "size 1600 900, ^(leaguecientux.exe)$"
            ];

            windowrulev2 = [
              "rounding 0, xwayland:1"
              "float, class:^(leagueclientux.exe)$,title:^(League of Legends)$"
              "immediate, class:^(osu\!)$"
            ];
            
          };
        };
      };
    })
  ];
}
