{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  cfg = config.display.hyprland;
  inherit (lib) mkEnableOption mkIf mkMerge mapAttrsToList;
in {
  options.display.hyprland = {
    enable = mkEnableOption "hyprland";
  };

  config = mkMerge [
    {
      inputs = {
        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

        hy3 = {
          url = "github:outfoxxed/hy3";
          inputs.hyprland.follows = "hyprland";
        };

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
        home.packages = with pkgs; [
          inputs.hyprcontrib.packages.${pkgs.system}.grimblast
          swww
          wluma
          satty
        ];

        wayland.windowManager.hyprland = {
          enable = true;
          xwayland.enable = true;
          plugins = [inputs.hy3.packages.x86_64-linux.hy3];
          package = inputs.hyprland.packages.${pkgs.system}.hyprland;

          extraConfig = ''

            bind = $mod+CONTROL, 1, hy3:focustab, index, 01
            bind = $mod+CONTROL, 2, hy3:focustab, index, 02
            bind = $mod+CONTROL, 3, hy3:focustab, index, 03
            bind = $mod+CONTROL, 4, hy3:focustab, index, 04
            bind = $mod+CONTROL, 5, hy3:focustab, index, 05
            bind = $mod+CONTROL, 6, hy3:focustab, index, 06
            bind = $mod+CONTROL, 7, hy3:focustab, index, 07
            bind = $mod+CONTROL, 8, hy3:focustab, index, 08
            bind = $mod+CONTROL, 9, hy3:focustab, index, 09
            bind = $mod+CONTROL, 0, hy3:focustab, index, 10
              plugin {
                hy3 {
                  no_gaps_when_only = 2

                  tabs {
                    render_text = false
                    padding = 4
                    rounding = 8
                    text_center = true
                  }

                  autotile {
                    enable = true
                    trigger_width = 800
                    trigger_height = 500
                  }
                }
              }
          '';
          settings = let
            # swww = "${pkgs.swww}/bin/swww";
            playerctl = "${pkgs.playerctl}/bin/playerctl";
            pactl = "${pkgs.pulseaudio}/bin/pactl";
            # pamixer = "${pkgs.pamixer}/bin/pamixer";

            #stolen from fufexan

            screenshotarea = "hyprctl keyword animation 'fadeOut,0,0,default'; grimblast --notify copysave area; hyprctl keyword animation 'fadeOut,1,4,default'";
            # screensatty = "$satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png";
          in {
            env = mapAttrsToList (name: value: "${name},${toString value}") {
              # XCURSOR_SIZE = 24;
              GDK_SCALE = 1.3;
              # WLR_DRM_NO_ATOMIC = 1;
              XDG_SESION_TYPE = "wayland";
              GDK_BACKEND = "wayland";
              # TERM = "foot";
              NIXOS_OZONE_WL = "1";
            };

            monitor = [
              "eDP-1,preferred,0x0, 1"
              ",preferred,auto, 1, mirror, eDP-1"
            ];

            exec-once = [
              # "${pkgs.foot}/bin/foot --server"
              "hypridle"
              # "${swww} init &"
              "${pkgs.wluma}/bin/wluma"
              # "hyprlock"
              "foot --server"
              "mako"
              "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store #Stores only text data"
              "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store #Stores only image data"
              # "./scripts/dynamic-borders.sh"
              #wait a bit
              "sleep 3"

              # "${swww} img ${../../wallpapers/6window_V2.jpg}"
              "ags -c ~/.nixConfig/modules/programs/ags/config.js"

              "sleep 2"
              "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

              "walker --gapplication-service"
            ];

            general = {
              gaps_in = 1;
              gaps_out = 2;
              border_size = 1;

              allow_tearing = true;

              layout = "hy3";
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
              new_on_top = false;
              no_gaps_when_only = false;
              orientation = "top";
              mfact = 0.6;
              always_center_master = false;
            };

            animation = {
              bezier = [
                "easeOutCirc, 0, 0.55, 0.45, 1"
                "easeOutCubic, 0.33, 1, 0.68, 1"
                "easeinoutsine, 0.37, 0, 0.63, 1"
                "linear, 0, 0, 1, 1"
                "md3_standard, 0.2, 0, 0, 1"
                "md3_decel, 0.05, 0.7, 0.1, 1"
                "md3_accel, 0.3, 0, 0.8, 0.15"
                "overshot, 0.05, 0.9, 0.1, 1.1"
                "crazyshot, 0.1, 1.5, 0.76, 0.92 "
                "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
                "fluent_decel, 0.1, 1, 0, 1"
                "easeInOutCirc, 0.85, 0, 0.15, 1"
                "easeOutCirc, 0, 0.55, 0.45, 1"
                "easeOutExpo, 0.16, 1, 0.3, 1"
                "softAcDecel, 0.26, 0.26, 0.15, 1"
              ];

              animation = [
                "windows, 1,7,hyprnostretch, slide"
                #STOLEN FROM :https://discord.com/channels/961691461554950145/1162860692978794627
              ];
            };

            input = {
              follow_mouse = 0;
              force_no_accel = 1;

              kb_layout = "us";
              kb_options = "grp:alt_shift_toggle, ctrl:nocaps";

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
              key_press_enables_dpms = true;
              disable_hyprland_logo = true;
            };

            "$mod" = "SUPER";
            "$smod" = "SHIFT+$mod";

            "$cmod" = "CONTROL+$mod";
            "$scmod" = "CONTROL+SHIFT+$mod";
            bind = [
              #Programs related
              # "$mod, space, exec, anyrun"
              "$mod, space, exec, fuzzel"
              # Launches foot with a tmux sesison -> got it from https://discord.com/channels/601130461678272522/1136357112579108904
              "$mod, return, exec,wezterm "
              "CTRL,F,exec, floorp "

              "CTRL, D,exec, ferdium"

              #screenshot
              ", Print, exec, ${screenshotarea}"
              "$mod SHIFT, R, exec, grimblast --freeze save area - | satty -f- --early-exit --copy-command wl-copy --init-tool rectangle"
              "CTRL, Print, exec, grimblast --notify --cursor copysave output"
              "$mod SHIFT CTRL, R, exec, grimblast --notify --cursor copysave output"
              "ALT, Print, exec, grimblast --notify --cursor copysave screen"
              "$mod SHIFT ALT, R, exec, grimblast --notify --cursor copysave screen"

              #windows managment related
              "$mod, SEMICOLON, exit,"
              "$smod, f, fullscreen"
              "$mod, v, togglefloating"

              "$smod, q, hy3:killactive"

              "$mod, d, hy3:makegroup, h"
              "$mod, s, hy3:makegroup, v"
              # "$smod,s  ,exec, hyprlock"
              "$mod, TAB, hy3:makegroup, tab"
              "$mod, a, hy3:changefocus, raise"
              "$smod, a, hy3:changefocus, lower"
              "$mod, e, hy3:expand, expand"
              "$smod, e, hy3:expand, base"
              "$mod, r, hy3:changegroup, opposite"
              "$scmod, r, hy3:changegroup, toggletab "

              "$mod, h, hy3:movefocus, l"
              "$mod, j, hy3:movefocus, d"
              "$mod, k, hy3:movefocus, u"
              "$mod, l, hy3:movefocus, r"

              "$cmod, h, hy3:movefocus, l, visible"
              "$cmod, j, hy3:movefocus, d, visible"
              "$cmod, k, hy3:movefocus, k, visible"
              "$cmod, l, hy3:movefocus, r, visible"

              "$smod, h, hy3:movewindow, l, once"
              "$smod, j, hy3:movewindow, d, once"
              "$smod, k, hy3:movewindow, u, once"
              "$smod, l, hy3:movewindow, r, once"

              "$scmod, h, hy3:movewindow, l, once, visible"
              "$scmod, j, hy3:movewindow, d, once, visible"
              "$scmod, k, hy3:movewindow, u, once, visible"
              "$scmod, l, hy3:movewindow, r, once, visible"

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
                  in ''
                    bind = $mod, ${ws}, workspace, ${toString (x + 1)}
                    bind = $modSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
                  ''
                )
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
              # "forceinput,^(league of legends.exe)$"
              "size 1600 900, ^(leaguecientux.exe)$"
            ];

            windowrulev2 = [
              "rounding 0, xwayland:1"
              "float, class:^(leagueclientux.exe)$,title:^(League of Legends)$"
              # "immediate, class:^(osu\!)$"
            ];
          };
        };
      };
    })
  ];
}
