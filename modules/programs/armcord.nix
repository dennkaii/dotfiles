{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.programs.armcord;
  inherit (lib) mkEnableOption mkIf;
in {
  options.programs.armcord = {
    enable = mkEnableOption "armcord";
  };

  config = mkIf cfg.enable {
    inputs = {
      armcord-hm.url = ",ithub:n3oney/armcord-hm";
      armcord-hm.inputs.nixpkgs.follows = "nixpkgs";
    };

    hmModules = [inputs.armcord-hm.homeManagerModules.default];

    hm = {
      programs.armcord = {
        enable = true;
        armcordSettings = {
          # here's mine:
          alternativePaste = false;
          armcordCSP = true;
          automaticPatches = false;
          channel = "stable";
          disableAutogain = true;
          minimizeToTray = false;
          multiInstance = false;
          performanceMode = "performance";
          skipSplash = true;
          spellcheck = true;
          startMinimized = false;
          tray = true;
          trayIcon = "default";
          useLegacyCapturer = false;
          # windowStyle = "transparent";
        };
      };
    };
  };
}
