{
  config,
  lib,
  ...
}: let
  cfg = config.services.tailscale;
  inherit (lib) mkEnableOption mkIf;
in {
  options.services.tailscale.enable = mkEnableOption "tailscale";

  config = mkIf cfg.enable {
    os.services.tailscale.enable = true;
    # os.services.tailscale.port = "0";
  };
}
