{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.programs.fish;
  inherit (lib) mkEnableOption mkIf;
in {
  options.programs.fish = {
    enable = mkEnableOption "fish";
  };

  config = mkIf cfg.enable {
    os = {
      users.defaultUserShell = pkgs.fish;
      programs.fish.enable = true;
    };

    hm = {
      programs.starship.enableFishIntegration = true;

      programs.zellij = {
        enable = true;
        settings = {
          default_shell = "fish";
          # theme = "default";
          simplified_ui = true;
          pane_frames = false;
          default_layout = "compact";
        };
      };

      programs.eza = {
        enable = true;
        # enableAliases = true;
        icons = true;
      };

      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting

        '';
      };
    };
  };
}
