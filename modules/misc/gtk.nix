{
  pkgs,
  config,
  lib,
  ...
}:let
cfg = config.gtk;
inherit(lib) mkEnableOption mkIf;
in {
  options.gtk.enable = mkEnableOption "gtk";


  config = mkIf cfg.enable {
    hm = {
      home.packages = [pkgs.dconf];
      dconf.enable = true; #wiki says gtk may not work without it

      gtk = {
        enable = true;
        
        gtk3.extraConfig = {
          gtk-decoration-layout = ":menu"; # disable title bar buttons
        };

        #Fonts are already manager by stylix 

        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };

        # cursorTheme = {
        #   name = "GoogleDot-White";
        #   size = 24;
        #   package = pkgs.google-cursor;
        # };

             
      };
    };
  };
}
