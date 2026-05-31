{
  programs.nixvim.plugins.auto-session = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings.event = [ "BufReadPre" ];
    };
    settings = {
      auto_restore_enabled = true;
      auto_save_enabled = true;
      auto_session_suppress_dirs = [
        "~/"
        "~/Downloads"
        "~/Documents"
        "~/Documents/Main/"
        "~/src/"
        "~/cylisos"
      ];
    };
  };
}
