{
  # pkgs,
  config,
  lib,
  ...
}:let
cfg = config.programs.starship;
inherit(lib) mkIf mkEnableOption;
in {
  options.programs.starship = {
    enable = mkEnableOption "starship";
  };

  config = mkIf cfg.enable{
    hm.programs.starship = {
      enable = true;
      enableFishIntegration = true;
      #TODO => add custom prompt
    };
  };
}
