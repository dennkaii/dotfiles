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
        sensibleOnTop = true;
        disableConfirmationPrompt = true;
        baseIndex = 1;
        mouse = true;
        newSession = true;

        extraConfig = ''
          set -g allow-passthrough on
          set -ga update-environment TERM
          set -ga update-environment TERM_PROGRAM
          set -g status-position top
          set -g status-interval 1



        '';

        plugins = with pkgs; [
          tmuxPlugins.sensible
          {
            plugin = tmuxPlugins.rose-pine;
            extraConfig = ''
              set -g @rose_pine_variant 'main'
              set -g @rose_pine_date_time '%_I:%M %a %D'
              set -g @rose_pine_show_pane_directory 'on'
              set -g @rose_pine_status_left_prepend_section '#{tmux_mode_indicator}'
              set -g @rose_pine_show_current_program 'on'
              set -g @rose_pine_show_pane_directory 'on'
            '';
          }

          tmuxPlugins.pain-control
          {
            plugin = tmuxPlugins.mode-indicator;
            extraConfig = ''
              set -g @mode_indicator_prefix_prompt ' WAIT '
              set -g @mode_indicator_copy_prompt ' COPY '
              set -g @mode_indicator_sync_prompt ' SYNC '
              set -g @mode_indicator_empty_prompt ' TMUX '
              set -g @mode_indicator_prefix_mode_style 'bg=#191724,fg=blue'
              set -g @mode_indicator_copy_mode_style 'bg=#191724,fg=yellow'
              set -g @mode_indicator_sync_mode_style 'bg=#191724,fg=red'
              set -g @mode_indicator_empty_mode_style 'bg=#191724,fg=cyan'
            '';
          }
          {
            plugin = tmuxPlugins.extrakto;
            extraConfig = ''
              set -g @extrakto_clip_tool wl-copy
              set -g @extrakto_editor hx
              set -g @extrakto_open_tool floorp
              set -g @extrakto_filter_order 'url path line word'
            '';
          }
        ];
      };
    };
  };
}
