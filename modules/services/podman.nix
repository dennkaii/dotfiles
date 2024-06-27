{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.services.podman;
in {
  options.services.podman.enable = lib.mkEnableOption "podman";
  config = lib.mkIf cfg.enable {
    users.groups = ["podman"];

    os.virtualisation.podman.enable = true;
  };
}
