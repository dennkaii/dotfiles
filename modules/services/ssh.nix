{
  # pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.services.ssh;
  inherit (lib) mkIf mkEnableOption;
in {
  options.services.ssh = {
    enable = mkEnableOption "ssh";
  };

  config = mkIf cfg.enable {
    os = {
      services.openssh.enable = true;

      programs.ssh.startAgent = true;
    };
  };
}
