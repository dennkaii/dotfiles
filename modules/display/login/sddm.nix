{
  lib,
  config,
  ...
}: let
  cfg = config.display.sddm;
  inherit (lib) mkEnableOption mkIf;
in {
  options.display.sddm = {
    enable = mkEnableOption "sddm";
  };

  config = mkIf cfg.enable {
    os = {
      services.xserver = {
        enable = true;

        desktopManager = {
          runXdgAutostartIfNone = true;
        };
        displayManager = {
          sddm = {
            enable = true;
            # autoLogin = {
            #   enable = true;
            #   user = "${config.users.main}";
            # };
          };
        };
      };
    };
  };
}
