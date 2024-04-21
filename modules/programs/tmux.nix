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

        extraConfig = ''
          set-option -g status-position top

          bind g source-file ~/.config/tmux/tmux.conf

          set -g status-right "Online: #{online_status}"

           # Easier reload of config
        '';

        plugins = with pkgs; [
          # tmuxPlugins.tmux-thumbs
          tmuxPlugins.copycat
          # tmuxPlugins.better-mouse-mode
          tmuxPlugins.sidebar
          # {
          #   plugin = tmuxPlugins.resurrect;
          #   extraConfig = ''
          #             set -g @resurrect-strategy-vim 'session'
          #     set -g @resurrect-strategy-nvim 'session'
          #     set -g @resurrect-capture-pane-contents 'on'

          #   '';
          # }
          tmuxPlugins.sensible
          tmuxPlugins.pain-control
          tmuxPlugins.online-status
          tmuxPlugins.mode-indicator
          # {
          #   plugin = tmuxPlugins.continuum;
          #   extraConfig = ''
          #     set -g @continuum-restore 'on'
          #     set -g @continuum-boot 'on'
          #     set -g @continuum-save-interval '10'
          #   '';
          # }
        ];
      };
    };
  };
}
