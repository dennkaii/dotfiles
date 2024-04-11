{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) getExe concatStringsSep;

  initialSession = {
    user = "${config.users.main}";
    command = "Hyprland";
  };

  defaultSession = {
    user = "greeter";
    command = concatStringsSep " " [
      (getExe pkgs.greetd.tuigreet)
      "--time"
      "--remember"
      "--remember-user-session"
      "asterisks"
    ];
  };
in {
  os.services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session = defaultSession;

      initial_session = initialSession;
    };
  };
}
