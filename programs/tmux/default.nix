{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    aggressiveResize = true; # temp
    baseIndex = 1;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    secureSocket = true; # temp
    shell = "${pkgs.fish}/bin/fish";
    prefix = "C-s";
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      rose-pine
      yank
      sensible
      vim-tmux-navigator
      continuum
      tmux-sessionx
    ];

    extraConfig = ''
      # Keybinds
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind-key -n M-j previous-window
      bind-key -n M-k next-window
      bind-key -n M-h previous-window
      bind-key -n M-l next-window
      bind-key -n 'C-h' 'select-pane -L'
      bind-key -n 'C-j' 'select-pane -D'
      bind-key -n 'C-k' 'select-pane -U'
      bind-key -n 'C-l' 'select-pane -R'
      bind-key -n C-l send-keys 'C-l'
      bind-key x kill-pane
      bind-key "U" run-shell -b "xdg-open $(tmux capture-pane -J -p | grep -oE '(https?):\/\/.*[^>]' | fzf-tmux -d20 --multi --bind alt-a:select-all,alt-d:deselect-all)"

      # Sesh
      bind-key "K" display-popup -E -w 40% "${pkgs.sesh}/bin/sesh connect \"$(
        ${pkgs.sesh}/bin/sesh list -i | ${pkgs.gum}/bin/gum filter --limit 1 --placeholder 'Pick A session' --prompt='⚡'
      )\""

      # Theme Settings
      set -g @rose_pine_variant "moon"
      set -g @rose_pine_date_time "%a, %d %b, %H:%M"
      set -g @rose_pine_directory "off" 

      set -g @rose_pine_disable_active_window_menu 'off' 

      set -g @rose_pine_show_current_program "off"
      set -g @rose_pine_show_pane_directory "off"

      set -g @rose_pine_default_window_behavior "off"

      # These are not padded
      set -g @rose_pine_session_icon '' 
      set -g @rose_pine_current_window_icon '' 
      set -g @rose_pine_folder_icon '' 
      set -g @rose_pine_username_icon '' 
      set -g @rose_pine_hostname_icon '󰒋' 
      set -g @rose_pine_date_time_icon '󰃰' 
      set -g @rose_pine_window_status_separator "  " 


      set -g @rose_pine_prioritize_windows "off" 
      set -g @rose_pine_width_to_hide '80' 
      set -g @rose_pine_window_count '5' 

      # Settings
      set-option -g @resurrect-strategy-nvim 'session'
      set-option -sa terminal-overrides ',xterm*:Tc'
      set-option -ga terminal-overrides ',xterm*:Ss=\E[%p1%d q:Se=\E[ q'
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
      set -g default-terminal "tmux"
      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-restore 'on'
      set-option -g status-position top
      set -g detach-on-destroy off
    '';
  };
}
