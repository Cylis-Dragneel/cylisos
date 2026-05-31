{
  programs.nixvim.plugins.comment = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings.keys = [
        {
          __unkeyed-1 = "gc";
          mode = [ "n" "v" ];
        }
      ];
    };
    settings.pre_hook.__raw = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
  };
}
