{
  pkgs,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    enableZshIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
      # theme = "/home/${username}/.config/ghostty/tokyonight_storm";
      theme = "Rose Pine Moon";
      font-size = 11;
      font-family = [
        ""
        "Maple Mono NF CN Medium"
      ];
      font-feature = [
        "calt"
        "cv01"
        "cv02"
        "cv03"
        "cv31"
        "ss03"
      ];
      cursor-style = "underline";
      mouse-hide-while-typing = true;
      background-opacity = 0.7;
      unfocused-split-opacity = 0.7;
      title = "Ghostty";
      keybind = [
        "ctrl+shift+r=reload_config"
        "ctrl+backspace=text:\\x1b\\x7f"
      ];
      window-decoration = false;
      window-theme = "ghostty";
      focus-follows-mouse = false;
      clipboard-read = "allow";
      clipboard-write = "allow";
      confirm-close-surface = false;
      shell-integration-features = "cursor,no-sudo,title";
      term = "xterm-ghostty";
    };
  };
}
