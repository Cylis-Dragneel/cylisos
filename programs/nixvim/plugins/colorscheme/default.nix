{
  programs.nixvim.colorschemes.rose-pine = {
    enable = true;
    lazyLoad.enable = true;
    settings = {
      variant = "moon";
      dim_inactive_windows = false;
      disable_background = true;
      extended_background_behind_borders = false;
      styles = {
        bold = true;
        italic = true;
        transparency = true;
      };
      highlight_groups = {
        TelescopeBorder = {
          fg = "highlight_high";
          bg = "none";
        };
        TelescopeNormal.bg = "none";
        TelescopePromptNormal.bg = "none";
        TelescopeResults = {
          fg = "subtle";
          bg = "none";
        };
        TelescopeResultsNormal = {
          fg = "subtle";
          bg = "none";
        };
        TelescopePreview = {
          fg = "text";
          bg = "none";
        };
        TelescopePreviewNormal = {
          fg = "text";
          bg = "none";
        };
        TelescopeSelection = {
          fg = "text";
          bg = "none";
        };
        TelescopeSelectionCaret = {
          fg = "rose";
          bg = "none";
        };
        StatusLine = {
          fg = "love";
          bg = "love";
          blend = 10;
        };
        StatusLineNC = {
          fg = "subtle";
          bg = "surface";
        };
      };
    };
  };

  programs.nixvim.colorscheme = "rose-pine-moon";
}
