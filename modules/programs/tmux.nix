{
  config,
  lib,
  ...
}:let
  cfg = config.programs.tmux;
  inherit(lib) mkEnableOption mkIf;
  in {
    options.programs.tmux.enable = mkEnableOption "tmux";

    config = mkIf cfg.enable {
      hm = {
        programs.tmux = {
          enable = true;

          
        };
      };
    };
  }
