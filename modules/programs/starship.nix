{
  # pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.starship;
  inherit (lib) mkIf mkEnableOption;
in {
  options.programs.starship = {
    enable = mkEnableOption "starship";
  };

  config = mkIf cfg.enable {
    hm.programs.starship = {
      enable = true;

      #The integration line is in each shell file
      # enableFishIntegration = true;
      #TODO => add custom prompt

      settings = {
        add_newline = false;
        scan_timeout = 10;
        format = "$directory$fill$git_branch$git_status$cmd_duration$line_break$character";

        directory = {
          truncation_length = 4;
        };

        battery = {
          full_symbol = "🔋";
          charging_symbol = "⚡️";
          discharging_symbol = "💀";
        };

        # battery.display = {
        #   threshold = 30;
        #   style = "bold red";
        # };

        character = {
          success_symbol = "[◈](bold green)";
          error_symbol = "[◈](bold red)";
        };

        directory.substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };

        nix_shell = {
          symbol = " ";
          heuristic = true;
        };

        cmd_duration = {
          min_time = 1;
          format = " Took [$duration]($style) ";
          disabled = false;
          # style = "bg:none fg:${default.xcolors.mbg}";
        };
      };
    };
  };
}
