{
  programs.nixvim.plugins.bufferline = {
    enable = true;
    lazyLoad.enable = true;
    settings = {
      highlights.__raw = "require('rose-pine.plugins.bufferline')";
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<TAB>";
      action = "<cmd>BufferLineCycleNext<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<S-TAB>";
      action = "<cmd>BufferLineCyclePrev<CR>";
      options.silent = true;
    }
  ];
}
