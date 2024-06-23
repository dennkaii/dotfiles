{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.programs.nu;
  inherit (lib) mkEnableOption mkIf;
in {
  options.programs.nu.enable = mkEnableOption "nu";
  config = mkIf cfg.enable {
    os.users.defaultUserShell = pkgs.nushell;

    hm = {
      programs.starship.enableNushellIntegration = true;

      programs = {
        zoxide.enable = true;
        atuin.enable = true;
        broot.enable = true;
        carapace.enable = true;
      };

      programs.atuin.enableNushellIntegration = true;
      programs.broot.enableNushellIntegration = true;
      programs.zoxide.enableNushellIntegration = true;

      programs.zellij = {
        enable = false;

        settings = {
          default_shell = "nu";
          simplified_ui = true;
          pane_frames = false;
          default_layout = "compact";
        };
      };
      home.packages = [
        pkgs.fish
      ];

      programs.nushell = {
        enable = true;
        configFile.source = ./nushell/config.nu;
        envFile.source = ./nushell/env.nu;

        shellAliases = {
          sysupdate = "sudo nixos-rebuild switch --flake ~/.nixConfig/#Aethyr";
        };
      };
    };
  };
}
