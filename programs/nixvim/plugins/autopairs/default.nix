{
  programs.nixvim.plugins.mini = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings.event = [ "InsertEnter" ];
    };
    modules.pairs = { };
  };
}
