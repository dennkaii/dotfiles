{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.programs.waybar;
  inherit (lib) mkIf mkEnableOption;
in {
  options.programs.waybar.enable = mkEnableOption "waybar";

  config = mkIf cfg.enable {
    hm = {
      programs.waybar = {
        enable = true;

        settings = {
          mainBar = {
            layer = "top";
            position = "bottom";
            height = 15;

            modules-left = ["idle_inhibitor" "clock"];
            modules-center = ["river/tags"];
            modules-right = ["cpu" "network" "tray" "upower"];
            "river/tags" = {
              num-tags = 5;
              set-tag = [
                "2147483649"
                "2147483650"
                "2147483652"
                "2147483656"
                "2147483664"
              ];
            };
            "clock" = {
              format = "{:%a, %d %b, %I:%M %p}";
            };
            "cpu" = {
              max-length = 10;
            };
            "network" = {
              format = "{ipaddr}";
              format-disconnected = "???";
              tooltip-format = "connected to {ifname}. Up {bandwidthUpBits} / Down {bandwidthDownBits}";
            };
            "tray" = {
              icon-size = 16;
              spacing = 1;
            };
            "upower" = {
              show-icon = false;
              hide-if-empty = true;
              tooltip = false;
            };
            "idle_inhibitor" = {
              format = "{status}";
              format-icons = {
                activated = "(On)";
                desactivated = "(Off)";
              };
            };
          };
        };
        style = ''
          * {
            border: none;
            background: none;
            font-size: 14px;
            font-family: "JetBrainsMono Nerd Font,JetBrainsMono NF" ;
            min-height: 25px;
            }

            .modules-left,
            .modules-center,
            .modules-right{
              background:#262626;
            }

            label.module {
             color:#ffffff;
            padding:2px;
            margin-top:2px;
            }




        '';
      };
    };
  };
}
