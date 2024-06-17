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
      # services.displayManager.sessionPackages = let
      #   session = pkgs.stdenvNoCC.mkDerivation {
      #     name = "river-wayland-session";
      #     src = pkgs.writeTextDir "entry" ''
      #       Desktop Entry]
      #       Name=River
      #       Comment=A dynamic tiling Wayland compositor
      #       Exec=river
      #       Type=Application
      #     '';
      #     dontBuild = true;

      #     installPhase = ''
      #       mkdir -p $out/share/wayland-sessions
      #       cp entry $out/share/wayland-sessions/river.desktop
      #     '';
      #     passthru.providedSessions = ["river"];
      #   };
      # in [session];

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

        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-wlr
        ];
      };
    };
    hm = let
      cursor = {
        package = lib.mkForce pkgs.catppuccin-cursors.macchiatoTeal;
        name = lib.mkForce "Catppuccin-Macchiato-Teal-Cursors";
        size = lib.mkForce 24;
      };
    in {
      home.pointerCursor = {
        gtk.enable = true;
        name = cursor.name;
        package = cursor.package;
        size = cursor.size;
        x11 = {
          defaultCursor = cursor.name;
          enable = true;
        };
      };

      wayland.windowManager.river = {
        enable = true;
        xwayland.enable = true;
        settings = let
          layout = "rivertile";

          main = "Super";
          ssm = "Super+Shift";
          sas = "Super+Alt+Shift";
          sam = "Super+Alt";
          scm = "Super+Control";
          scam = "Super+Control+Alt";
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
              #screenShots Not Done yet
              # "${main} P" = ''spawn grim - | '';
              # "${ssm}  P" = ''spawn '';
              "${ssm} E" = "exit";
              "${ssm} F" = "toggle-fullscreen";
              "${main} Z" = "zoom";
              "${main} V" = "toggle-float";
              "${main} J" = "focus-view previous";
              "${main} K" = "focus-view next";
              "${ssm} Period" = "send-to-output next";
              "${ssm} Comma" = "send-to-output previous";

              # move viewss

              "${sam} H" = "move left 100";
              "${sam} J" = "move down 100";
              "${sam} K" = "move up 100";
              "${sam} L" = "move right 100";

              # snap vies to screen edges

              "${scam} H" = "snap left";
              "${scam} J" = "snap down";
              "${scam} K" = "snap up";
              "${scam} L" = "snap right";

              # resize views

              "${sas} H" = "resize horizontal -100";
              "${sas} J" = "resize vertical 100";
              "${sas} K" = "resize vertical -100";
              "${sas} L" = "resize horizontal 100";

              #increase and decrease the main ratio of rivertile
              "${main} L" = ''send-layout-cmd ${layout} "main-ratio -0.05"'';
              "${main} H" = ''send-layout-cmd ${layout} "main-ratio +0.05"'';

              #increment/decrement the main count of rivertile(1)
              "${ssm} H" = ''send-layout-cmd ${layout} "main-count +1"'';
              "${ssm} L" = ''send-layout-cmd ${layout} "main-count -1"'';
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
            "fcitx5"
            "${pkgs.bash} startup.sh"
          ];

          rule-add = {
            "-app-id" = {
              "'*'" = "ssd";
            };
          };

          # xcursor-theme = "${cursor.name} ${cursor.size}";
          set-repeat = "50 300";

          map-pointer = {
            normal = {
              "Super BTN_LEFT" = "move-view";
              "Super BTN_RIGHT" = "resize-view";
            };
          };
        };

        extraSessionVariables = {
          TERM = "foot";
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
  };
}
