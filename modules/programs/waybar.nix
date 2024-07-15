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

            modules-left = ["river/tags"];
            modules-center = ["clock"];
            modules-right = ["tray"];
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
            "tray" = {
              icon-size = 16;
              spacing = 1;
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
             window#waybar {
              background: #161616;

              }

              .modules-right {
                padding-left: 5px;
                border-radius:  15px 0px 0px 0px;
                margin-top: 2px;
                background: #262626;
              }

              .modules-center {
                padding: 0 15px;
                margin-top: 2px;
                border-radius: 15px 15px 0 0 ;
                background: #262626;
              }

              .modules-left {
                border-radius:   0 15px 0 0;

                margin-top: 2px;
                background: #262626;
              }

              #tags button:hover{
              background: #393939;
              }

        '';
      };
    };
  };
}
