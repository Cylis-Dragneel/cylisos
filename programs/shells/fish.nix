{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    generateCompletions = true;
    shellAliases = {
      rl = "source ~/.config/fish/config.fish";
      nix-shell = "nix-shell --command fish";
      nix-develop = "nix develop --command fish";
    };
    interactiveShellInit = ''
      fzf_configure_bindings
      set fzf_preview_dir_cmd eza --all --color=always
      # bind \t '__fzf_cd_completion; or commandline -f complete'
      # Case-insensitive tab completion (equivalent to matcher-list in ZSH)
      set -g fish_complete_path $fish_complete_path ~/.config/fish/completions

      # Configure fzf for directory previews
      function __fzf_cd_preview
        eza --color=always --icons $argv
      end

      # Set up fzf for Fish
      set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
      set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
      set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
      set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

      # Configure fzf preview for cd command
      set -gx FZF_ALT_C_OPTS "--preview='__fzf_cd_preview {}'"

      # Enable fzf key bindings if available
      if type -q fzf_key_bindings
        fzf_key_bindings
      end

      # Custom key binding for directory navigation (Alt+C)
      bind \ec 'fzf-cd-widget'
    '';
    plugins = [
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "v9.2"; # Use a specific version for stability
          sha256 = "sha256-XmRGe39O3xXmTvfawwT2mCwLIyXOlQm7f40mH5tzz+s=";
        };
      }
    ];
  };
}
