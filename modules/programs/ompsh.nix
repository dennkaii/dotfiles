{
  config,
  lib,
  ...
}: let
  cfg = config.programs.ompsh;
  inherit (lib) mkIf mkEnableOption;
in {
  options.programs.ompsh.enable = mkEnableOption "oh-my-posh toogle";

  config = mkIf cfg.enable {
    hm.programs.eza = {
      enable = true;
      enableNushellIntegration = true;
      # enableAliases = true;
      icons = true;
    };

    hm.programs.oh-my-posh = {
      enable = true;
      useTheme = "tokyonight_storm";
    };
  };
}
