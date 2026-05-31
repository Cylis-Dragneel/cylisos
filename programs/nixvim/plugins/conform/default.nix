{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings.event = [ "BufWritePre" ];
    };
    settings = {
      formatters_by_ft = {
        lua = [ "stylua" ];
        python = [
          "ruff_format"
          "ruff_organize_imports"
          "ruff_fix"
        ];
        rust = [ "rustfmt" "clippy" ];
        javascript = [ "prettierd" "prettier" ];
        go = [
          "gofumpt"
          "goimports_reviser"
          "golines"
        ];
        nix = [ "nixfmt" ];
      };
      format_on_save = {
        lsp_format = "fallback";
      };
    };
  };
}
