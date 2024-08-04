{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.gtk;
  inherit (lib) mkEnableOption mkIf;
in {
  options.gtk.enable = mkEnableOption "gtk";

  config = mkIf cfg.enable {
    hm = {
      home.packages = [pkgs.dconf];
      dconf.enable = true; #wiki says gtk may not work without it
      dconf.settings = {
        # disable dconf first use warning
        "ca/desrt/dconf-editor" = {
          show-warning = false;
        };
        # set dark theme for gtk 4
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };

      gtk = {
        enable = true;

        gtk3.extraConfig = {
          # gtk-decoration-layout = ":menu"; # disable title bar buttons
          gtk-application-prefer-dark-theme = 1;
        };
        gtk4.extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };

        #Fonts are already manager by stylix

        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
      };
    };
  };
}
