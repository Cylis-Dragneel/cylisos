{ pkgs, ... }:
let
  catppuccin = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub {
      owner = "dreamsofcode-io";
      repo = "catppuccin-tmux";
      rev = "main";
      sha256 = "sha256-FJHM6LJkiAwxaLd5pnAoF3a7AE1ZqHWoCpUJE0ncCA8=";
    };
  };
  tokyo-night = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tokyo-night";
    version = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub {
      owner = "janoamaral";
      repo = "tokyo-night-tmux";
      rev = "master";
      sha256 = "sha256-3rMYYzzSS2jaAMLjcQoKreE0oo4VWF9dZgDtABCUOtY=";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    mouse = true;
    aggressiveResize = true; # temp
    baseIndex = 1;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    secureSocket = true; # temp
    shell = "${pkgs.zsh}/bin/zsh";
    prefix = "C-s";
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      # tokyo-night
      # catppuccin
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
      # set -g @tokyo-night-tmux_window_id_style hsquare
      # set -g @tokyo-night-tmux_show_datetime 1
      # set -g @tokyo-night-tmux_date_format DMY
      # set -g @tokyo-night-tmux_time_format 24H
      # set -g @tokyo-night-tmux_show_path 0
      # set -g @tokyo-night-tmux_show_git 1
      set -g @rose_pine_variant "moon"
      set -g @rose_pine_date_time "%a, %d %b, %H:%M"
      set -g @rose_pine_directory "on" 

      # set -g @rose_pine_only_windows 'on' 
      # set -g @rose_pine_disable_active_window_menu 'on' 

      # set -g @rose_pine_default_window_behavior 'on' 
      # Previously set -g @rose_pine_window_tabs_enabled

      # Example values for these can be:
      set -g @rose_pine_left_separator ' > ' # The strings to use as separators are 1-space padded
      set -g @rose_pine_right_separator ' < ' # Accepts both normal chars & nerdfont icons
      set -g @rose_pine_field_separator ' | ' # Again, 1-space padding, it updates with prefix + I
      set -g @rose_pine_window_separator ' - ' # Replaces the default `:` between the window number and name

      # These are not padded
      set -g @rose_pine_session_icon '' 
      set -g @rose_pine_current_window_icon '' 
      set -g @rose_pine_folder_icon '' 
      set -g @rose_pine_username_icon '' 
      set -g @rose_pine_hostname_icon '󰒋' 
      set -g @rose_pine_date_time_icon '󰃰' 
      set -g @rose_pine_window_status_separator "  " 


      set -g @rose_pine_prioritize_windows 'on' 
      set -g @rose_pine_width_to_hide '80' 
      set -g @rose_pine_window_count '5' 

      # run-shell ${tokyo-night}/share/tmux-plugins/tokyo-night/tokyo-night.tmux

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

      # Old Catppuccin Settings
      # set-option -g @catppuccin_flavour 'macchiato'
      # set -g @catppuccin_window_left_separator ""
      # set -g @catppuccin_window_right_separator " "
      # set -g @catppuccin_window_middle_separator " █"
      # set -g @catppuccin_window_number_position "right"
      # set -g @catppuccin_window_default_fill "number"
      # set -g @catppuccin_window_default_text "#W"
      # set -g @catppuccin_window_current_fill "number"
      # set -g @catppuccin_window_current_text "#W"
      # set -g @catppuccin_status_modules_right "host session date_time"
      # set -g @catppuccin_status_left_separator  " "
      # set -g @catppuccin_status_right_separator ""
      # set -g @catppuccin_status_fill "icon"
      # set -g @catppuccin_status_connect_separator "no"
      # set -g @catppuccin_directory_text "#{pane_current_path}"
    '';
  };
}
