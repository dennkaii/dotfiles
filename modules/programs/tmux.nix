{
  config,
  lib,
  pkgs,
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
          shell = "${pkgs.nushell}/bin/nu";
          terminal = "tmux-256color";
          historyLimit = 100000;
          escapeTime = 0;
          keyMode = "vi";
          shortcut = "a";

          plugins = with pkgs;[
            tmuxPlugins.yank
            tmuxPlugins.tmux-thumbs
            tmuxPlugins.copycat
            tmuxPlugins.sidebar
            
          ];
          

          
        };
      };
    };
  }
