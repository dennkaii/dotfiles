{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.display.river;
in {
  options.display.river.enable = lib.mkEnableOption "river wm";
  config = lib.mkIf cfg.enable {
    os = {
      programs.river = {
        enable = true;
        extraPackages = with pkgs; [
          i3bar-river
          kile-wl
          river-bnf
          satty
          grim
          slurp
          i3status-rust
        ];
      };

      xdg.portal = {
        enable = true;

        extraPortals = [pkgs.xdg-desktop-portal-gtk];
      };
    };
    hm.programs.i3status-rust = {
      enable = true;
      bars = {
        default = {
          blocks = [
            {
              block = "music";
              format = ''$icon {$combo.str(max_w:20,rot_interval:0.5) $play $next |}'';
            }
            {
              block = "cpu";
              interval = 1;
            }
            {
              block = "battery";
            }
            {
              block = "time";
              interval = 60;

              format = {
                full = "$icon $timestamp.datetime(f:'%a %Y-%m-%d %R %Z', l:fr_BE) ";
                short = " $icon $timestamp.datetime(f:%R) ";
              };
            }
          ];
        };
      };
    };

    hm.wayland.windowManager.river = {
      enable = true;
      xwayland.enable = true;
      settings = let
        layout = "rivertile";

        main = "Super";
        ssm = "Super+Shift";
        sam = "Super+Alt";
        scm = "Super+Control";
        scam = "super+Control+Alt";
      in {
        default-layout = "${layout}";
        output-layout = "${layout}";
        border-width = 2;
        declare-mode = [
          "locked"
          "normal"
        ];
        map = {
          normal = {
            "${ssm} Q" = "close";
            "Super Return" = "spawn footclient";
            "Super SPACE" = "spawn fuzzel";
            "${ssm} E" = "exit";
            "${ssm} F" = "toggle-fullscreen";
            "${main} Z" = "zoom";
            "${main} V" = "toggle-float";
            "${main} H" = "focus-view previous";
            "${main} L" = "focus-view next";

            "Super+Shift H" = "swap previous";
            "Super+Shift L" = "swap next";
            "Super+Shift Period" = "send-to-output next";
            "Super+Shift Comma" = "send-to-output previous";
          };
        };
        spawn = [
          "${layout}"
          "${pkgs.foot}/bin/foot --server"
          "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store #Stores only text data"
          "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store #Stores only image data"
          "${pkgs.wluma}/bin/wluma"
          "fnott"
          "i3bar-river"
        ];

        rule-add = {
          "-app-id" = {
            "'*'" = "ssd";
          };
        };

        xcursor-theme = "phinger-cursors 24";
        set-repeat = "50 300";

        # focus-follows-cursor = "normal";
        map-pointer = {
          normal = {
            "Super BTN_LEFT" = "move-view";
            "Super BTN_RIGHT" = "resize-view";
          };
        };
      };

      extraSessionVariables = {
        TERM = "foot";
        WLR_DRM_NO_ATOMIC = 1;
        XDG_SESION_TYPE = "wayland";
        GDK_BACKEND = "wayland";
      };

      extraConfig = ''

        ${pkgs.bash}/bin/bash way-displays.sh

                  for i in $(seq 1 9)
                   do
                    tags=$((1 << ($i - 1)))
                  # Super+[1-9] to focus tag [0-8]
                     riverctl map normal Super $i set-focused-tags $tags
                  # Super+Shift+[1-9] to tag focused view with tag [0-8]
                     riverctl map normal Super+Shift $i set-view-tags $tags
                  # Super+Control+[1-9] to toggle focus of tag [0-8]
                     riverctl map normal Super+Control $i toggle-focused-tags $tags
                  # Super+Shift+Control+[1-9] to toggle tag [0-8] of focused view
                    riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
                    done
                  # Super+0 to focus all tags
                  # Super+Shift+0 to tag focused view with all tags
                    all_tags=$(((1 << 32) - 1))
                    riverctl map normal Super 0 set-focused-tags $all_tags
                    riverctl map normal Super+Shift 0 set-view-tags $all_tags




                  # Super+Alt+{H,J,K,L} to move views
                    riverctl map normal Super+Alt H move left 100
                    riverctl map normal Super+Alt J move down 100
                    riverctl map normal Super+Alt K move up 100
                    riverctl map normal Super+Alt L move right 100
                  # Super+Alt+Control+{H,J,K,L} to snap views to screen edges
                    riverctl map normal Super+Alt+Control H snap left
                    riverctl map normal Super+Alt+Control J snap down
                    riverctl map normal Super+Alt+Control K snap up
                    riverctl map normal Super+Alt+Control L snap righ

                  # Super+Alt+Shift+{H,J,K,L} to resize views
                    riverctl map normal Super+Alt+Shift H resize horizontal -100
                    riverctl map normal Super+Alt+Shift J resize vertical 100
                    riverctl map normal Super+Alt+Shift K resize vertical -100
                    riverctl map normal Super+Alt+Shift L resize horizontal 100

                  # Super+H and Super+L to decrease/increase the main ratio of rivertile(1)
                     # riverctl map normal Super H send-layout-cmd rivertile "main-ratio -0.05"
                     # riverctl map normal Super L send-layout-cmd rivertile "main-ratio +0.05"

                  # Super+Shift+H and Super+Shift+L to increment/decrement the main count of rivertile(1)
                    # riverctl map normal Super+Shift H send-layout-cmd rivertile "main-count +1"
                    # riverctl map normal Super+Shift L send-layout-cmd rivertile "main-count -1"

                  # Super+{Up,Right,Down,Left} to change layout orientation
                    riverctl map normal Super Up    send-layout-cmd rivertile "main-location top"
                    riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
                    riverctl map normal Super Down  send-layout-cmd rivertile "main-location bottom"
                    riverctl map normal Super Left  send-layout-cmd rivertile "main-location left"

                            function focus_tag_map
            {
                if [[ $(command -v river-bnf) ]]
                then
                    riverctl map "$1" "$2" "$3" spawn "river-bnf $4"
                else
                    riverctl map "$1" "$2" "$3" set-focused-tags "$4"
                fi
            }

            for i in $(seq 1 9)
            do
                tagmask=$(( 1 << ($i - 1) ))
                focus_tag_map normal Super $i $tagmask
            done

                            rivertile -view-padding 1 -outer-padding 1 &

      '';
    };
  };
}
