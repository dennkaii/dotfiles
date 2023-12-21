{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:let

cfg = config.programs.anyrun;
inherit(lib) mkEnableOption mkIf;

in {
  options.programs.anyrun = {
    enable = mkEnableOption "anyrun";
  };

  config = mkIf cfg.enable {
    inputs = {
      
    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";

    };

     hmModules = [inputs.anyrun.homeManagerModules.default];

    hm.programs.anyrun = {
        enable = true;

        config = {
          closeOnClick = true;
          hidePluginInfo = true;
          width.fraction = 0.3;
          y.fraction = 0.3;
         plugins = with inputs.anyrun.packages.${pkgs.system}; [
                    applications
                    rink
                    translate
                    websearch
          ];

      };
  extraCss = ''

  #window,
      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }

       #match:selected {
        background: rgba(203, 166, 247, 0.7);
      }

      #match {
        padding: 3px;
        border-radius: 5px;
      }

      #entry, #plugin:hover {
        border-radius: 16px;
      }

      box#main {
        background: rgb(30, 30, 46);
        border: 1px solid #1c272b;
        border-radius: 24px;
        padding: 8px;
      }

  '';


        };
  };
}
