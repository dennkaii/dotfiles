{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.tmux;
  inherit (lib) mkEnableOption mkIf;
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

        mouse = true;

        plugins = with pkgs; [
          tmuxPlugins.yank
          tmuxPlugins.tmux-thumbs
          tmuxPlugins.copycat
          tmuxPlugins.better-mouse-mode
          tmuxPlugins.sidebar
        ];
        extraConfig = ''
          set-option -g status-position top

           # Easier reload of config
          bind g source-file ~/.config/tmux/tmux.conf

          set-option -g status-right " #(uname-r)"

        '';
      };
    };
  };
}
