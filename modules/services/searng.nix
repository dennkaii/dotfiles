{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.services.searxng;
in {
  options.services.searxng.enable = lib.mkEnableOption "Search engine but better ig";

  config = lib.mkIf cfg.enable {
    os.users = {
      users.searx = {
        isSystemUser = true;
        createHome = false;
      };
    };
    os.services.searx = {
      enable = true;
      package = pkgs.searxng;
      # environmentFile = config.age.secrets.searx-key.path;
      settings = {
        use_default_settings = true;

        general = {
          instance_name = "Denkaixng";
        };
        server = {
          secret_key = "4d886b83069e6e5b450428eeeb811544";
        };
      };
    };
  };
}
