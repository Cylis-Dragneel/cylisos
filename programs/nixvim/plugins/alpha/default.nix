{
  programs.nixvim.plugins.alpha = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings.event = "VimEnter";
    };
    theme = "dashboard";
    settings.layout = [
      {
        type = "padding";
        val = 2;
      }
      {
        type = "text";
        opts = {
          hl = "Type";
          position = "center";
        };
        val = [
          "                                                     "
          "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ "
          "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ "
          "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ "
          "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ "
          "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ "
          "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ "
          "                                                     "
        ];
      }
      {
        type = "padding";
        val = 2;
      }
      {
        type = "group";
        val = [
          {
            type = "button";
            val = "  > New File";
            on_press.__raw = "function() vim.cmd[[ene]] end";
            opts.shortcut = "e";
          }
          {
            type = "button";
            val = "  > Toggle file explorer";
            on_press.__raw = "function() vim.cmd[[Oil]] end";
            opts.shortcut = "SPC e";
          }
          {
            type = "button";
            val = "󰱼 > Find File";
            on_press.__raw = "function() vim.cmd[[FzfLua files]] end";
            opts.shortcut = "SPC ff";
          }
          {
            type = "button";
            val = "  > Find Word";
            on_press.__raw = "function() vim.cmd[[FzfLua live_grep]] end";
            opts.shortcut = "SPC fr";
          }
          {
            type = "button";
            val = "󰁯  > Restore Session For Current Directory";
            on_press.__raw = "function() vim.cmd[[SessionRestore]] end";
            opts.shortcut = "SPC wr";
          }
          {
            type = "button";
            val = " > Quit NVIM";
            on_press.__raw = "function() vim.cmd[[qa]] end";
            opts.shortcut = "q";
          }
        ];
      }
    ];
  };

  programs.nixvim.autoCmd = [
    {
      event = [ "FileType" ];
      pattern = [ "alpha" ];
      command = "setlocal nofoldenable";
    }
  ];
}
