{
  pkgs,
  lib,
  config,
  ...
}: let
 cfg = config.fonts;
 inherit(lib) mkEnableOption mkIf;
in {
  options.fonts = {
    enable = mkEnableOption "fonts";
  };

  config = let 
    fonts = with pkgs; [
      material-symbols
      font-awesome_5
      # normal fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto
      monaspace
      
      (nerdfonts.override { fonts = [ "Mononoki" "JetBrainsMono" "FiraCode"]; })

    ];
    in 
     mkIf cfg.enable {
      os.fonts.packages = fonts;
      hm.home.packages = fonts;
      hm.fonts.fontconfig.enable = true;
    };
    
}
