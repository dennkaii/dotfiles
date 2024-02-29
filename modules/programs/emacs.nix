{
  pkgs,
  config,
  lib,
  ...
}: let
cfg = config.programs.emacs;
inherit(lib) mkIf mkEnableOption;
in {
  options.programs.emacs.enable = mkEnableOption "emacs";

  config = mkIf cfg.enable {
    hm = {
      services.emacs = {
        enable = true;

        client.enable = true;

      };
    };
  };
}
