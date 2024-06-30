{
  pkgs,
  lib,
  config,
  osConfig,
  inputs,
  ...
}: let
  cfg = config.programs.anyrun;
  inherit (lib) mkEnableOption mkIf;
in {
  options.programs.anyrun = {
    enable = mkEnableOption "anyrun";
  };

  config = mkIf cfg.enable {
    inputs = {
      anyrun.url = "github:Kirottu/anyrun";
      anyrun-nixos-options.url = "github:n3oney/anyrun-nixos-options/v2.0.0";
      anyrun.inputs.nixpkgs.follows = "nixpkgs";
    };

    hmModules = [inputs.anyrun.homeManagerModules.default];

    hm.programs.anyrun = {
      enable = true;

      config = {
        closeOnClick = false;
        hidePluginInfo = true;
        width.fraction = 0.5;
        showResultsImmediately = true;
        y.fraction = 0.2;
        maxEntries = 3;
        plugins = with inputs.anyrun.packages.${pkgs.system}; [
          applications
          shell
          rink
          translate
          websearch
          inputs.anyrun-nixos-options.packages.${pkgs.system}.default
        ];
      };
      extraConfigFiles."nixos-options.ron".text = let
        nixos-options = osConfig.system.build.manual.optionsJSON + "/share/doc/nixos/options.json";
        hm-options = inputs.home-manager.packages.${pkgs.system}.docs-json + "/share/doc/home-manager/options.json";
        options = builtins.toJSON {
          ":nix" = [nixos-options];
          ":hm" = [hm-options];
        };
      in ''
        Config(
          options: ${options},
        )
      '';

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
