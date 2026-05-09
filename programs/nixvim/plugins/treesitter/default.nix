{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = false;
      highlight.enable = true;
      indent.enable = true;
      folding.enable = true;
    };
  };

  programs.nixvim.plugins.indent-blankline = {
    enable = true;
    settings.scope.enabled = true;
  };

  programs.nixvim.extraConfigLua = ''
    require("ibl").setup()
    require("colorizer").setup()
  '';
}
