{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.programs.prism;
in {
  options.programs.prism.enable = lib.mkEnableOption "changes wallpaper colorsheme";
  config = lib.mkIf cfg.enable {
    inputs.prism.url = "github:IogaMaster/prism";

    hmModules = [inputs.prism.homeModules.prism];
    hm = {
      prism = {
        enable = true;
        wallpapers = ../../wallpapers;
        outPath = "../../colored_wallpapers";
        colorscheme = "adventure";
      };
    };
  };
}
