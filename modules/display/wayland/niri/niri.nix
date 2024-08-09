{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  cfg = config.display.niri;
in {
  options.display.niri = {
    enable = lib.mkEnableOption "niri";
  };
  config = lib.mkIf cfg.enable {
    inputs = {
      niri.url = "github:Sodiboo/niri-flake";
    };

    osModules = [inputs.niri.nixosModules.niri];
    # hmModules = [inputs.niri.homeModules.niri];

    os.programs = {
      niri.enable = true;
      package = inputs.niri.packages.${pkgs.hostPlatform.system}.niri-unstable;
      settings = {
        outputs."eDP-1" = {
          enable = true;
        };
      };

      binds = let
        mod = "Super";
        ssm = "${mod}+Shift";
        sam = "${mod}+Alt";
        sas = "${sam}+Shift";
        scm = "${mod}+Control";
        # scam = "${scm}+Alt";
      in
        with config.lib.niri.actions; {
          "${mod}+Return".action = spawn "wezterm";
          "${mod}+Space".action = spawn "fuzzel";
        };

      input = {
        workspace-auto-back-and-forth = true;

        mouse = {
          # natural-scroll = false;
        };
        touchpad = {
          scroll-method = "two-finger";
          accel-profile = "flat";
          click-method = "clickfinger";
          dwt = true;
          natural-scroll = false;
        };
      };
    };
  };
}
