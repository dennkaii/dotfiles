{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:let
cfg = config.programs.stylix;
inherit(lib) mkIf mkEnableOption;
in {
  options.programs.stylix.enable = mkEnableOption "stylix";

  config = mkIf cfg.enable {
    inputs.stylix.url = "github:danth/stylix";

    hmModules = [ inputs.stylix.homeManagerModules.stylix ];

    hm = {
       stylix = {
         image = ../../wallpapers/6window_V2.jpg;
        polarity = "dark";

        opacity = {
          terminal = 0.75;
        };

        fonts = {
          serif = {
          name = "Monaspace Neon";
          package = pkgs.monaspace;
          };
          sansSerif = {
            name = "Fira Code";
            package = pkgs.fira-code;
          };
          monospace = {
            name = "Monaspace Argon";
            package = pkgs.monaspace;
          };

          sizes = {
            applications = 11;
            desktop = 11;
          };

          
          
        };
        override = {
          scheme = "Oxocarbon Dark";
          author = "shaunsingh/IBM";
          base00 = "161616";
          base01 = "262626";
          base02 = "393939";
          base03 = "525252";
          base04 =  "dde1e6";
          base05 = "f2f4f8";
          base06 = "ffffff";
          base07 = "08bdba";
          base08 = "3ddbd9";
          base09 = "78a9ff";
          base0A = "ee5396";
          base0B = "33b1ff";
          base0C = "ff7eb6";
          base0D = "42be65";
          base0E = "be95ff";
          base0F = "82cfff";
        } ;       

         # base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-light.yaml";

      };        
    };
  };
}
