{
  programs.nixvim.plugins.lualine = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings.event = [ "VimEnter" ];
    };
    settings = {
      icons_enabled = true;
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [
          "branch"
          "diff"
          "diagnostics"
        ];
        lualine_c = [ "filename" ];
        lualine_x = [
          "filetype"
          "filesize"
        ];
        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
      inactive_sections = {
        lualine_a = [ ];
        lualine_b = [ ];
        lualine_c = [ ];
        lualine_x = [ "encoding" ];
        lualine_y = [ ];
        lualine_z = [ ];
      };
      theme = "rose-pine";
    };
  };
}
