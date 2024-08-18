{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.fonts;
  inherit (lib) mkEnableOption mkIf;
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
      sf-mono-liga-bin

      (nerdfonts.override {fonts = ["Mononoki" "JetBrainsMono" "FiraCode"];})
    ];
  in
    mkIf cfg.enable {
      inputs = {
        # SFMono w/ patches
        sf-mono-liga-src = {
          url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
          flake = false;
        };
      };

      os.nixpkgs.overlays = [
        (final: prev: {
          sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
            pname = "sf-mono-liga-bin";
            version = "dev";
            src = inputs.sf-mono-liga-src;
            dontConfigure = true;
            installPhase = ''
              mkdir -p $out/share/fonts/opentype
              cp -R $src/*.otf $out/share/fonts/opentype/
            '';
          };
        })
      ];

      os.fonts.packages = fonts;
      hm.home.packages = fonts;
      hm.fonts.fontconfig.enable = true;
    };
}
