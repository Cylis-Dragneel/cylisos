{
  programs.nixvim.plugins.cmp = {
    enable = true;
    lazyLoad.enable = true;
    autoEnableSources = true;
    settings = {
      completion.completeopt = "menu,menuone,preview,noselect";
      snippet.expand.__raw = ''
        function(args)
          require("luasnip").lsp_expand(args.body)
        end
      '';
      window = {
        completion = {
          border = "rounded";
        };
        documentation = {
          border = "rounded";
        };
      };
      mapping = {
        "<C-b>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
      };
      sources = [
        { name = "luasnip"; }
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
      formatting.format.__raw = ''
        require("lspkind").cmp_format({
          mode = "symbol",
          maxwidth = 50,
          ellipsis_char = "...",
          symbol_map = { Codecompanion = "" },
        })
      '';
    };
  };

  programs.nixvim.plugins.cmp_luasnip = {
    enable = true;
    lazyLoad.enable = true;
  };

  programs.nixvim.plugins.cmp-buffer = {
    enable = true;
    lazyLoad.enable = true;
  };

  programs.nixvim.plugins.cmp-nvim-lsp = {
    enable = true;
    lazyLoad.enable = true;
  };

  programs.nixvim.plugins.luasnip = {
    enable = true;
    lazyLoad.enable = true;
    fromVscode = [ { } ];
  };

  programs.nixvim.plugins.lspkind = {
    enable = true;
    lazyLoad.enable = true;
  };

  programs.nixvim.extraConfigLua = ''
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    ls.add_snippets("go", {
      s("errf", {
        t("if err != nil {"),
        t({ "", '\tlog.Fatal("Error: ", err)' }),
        t({ "", "}" }),
      }),
    })
  '';
}
