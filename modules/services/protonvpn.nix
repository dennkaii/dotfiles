{
  config,
  lib,
  pkgs,
  ...
}: let 
cfg = config.services.protonvpn;
in {
  options.services.protonvpn.enable = lib.mkEnableOption "protonvpn";

  config = lib.mkIf cfg.enable{
    hm.home.packages = with pkgs; [
      protonvpn-gui
      protonvpn-cli_2
    ];
  };
}
