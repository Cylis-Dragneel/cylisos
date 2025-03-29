{
  pkgs,
  inputs,
  ...
}:
let
  finecmdline = pkgs.vimUtils.buildVimPlugin {
    name = "fine-cmdline";
    src = inputs.fine-cmdline;
  };
in
{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        # LSP
        vscode-langservers-extracted
        zls
        rust-analyzer
        yaml-language-server
        lua-language-server
        nixd
        astro-language-server
        elixir-ls
        harper
        vtsls
        # haskell-language-server
        gopls
        basedpyright
        vim-language-server
        bash-language-server
        marksman
        luajitPackages.lua-lsp
        #Misc.
        # Formatters
        rustfmt
        clippy
        gofumpt
        golines
        goimports-reviser
        stylua
        prettierd
        nixfmt-rfc-style
      ];
      plugins = with pkgs.vimPlugins; [
        smart-open-nvim
        neocord
        copilot-vim
        codecompanion-nvim
        none-ls-nvim
        vim-wakatime
        mini-nvim
        obsidian-nvim
        catppuccin-nvim
        tokyonight-nvim
        nvim-colorizer-lua
        alpha-nvim
        auto-session
        which-key-nvim
        bufferline-nvim
        dressing-nvim
        indent-blankline-nvim
        nui-nvim
        finecmdline
        nvim-treesitter.withAllGrammars
        lualine-nvim
        nvim-autopairs
        nvim-web-devicons
        nvim-cmp
        nvim-lspconfig
        cmp-nvim-lsp
        cmp-buffer
        luasnip
        cmp_luasnip
        friendly-snippets
        lspkind-nvim
        comment-nvim
        nvim-ts-context-commentstring
        plenary-nvim
        luasnip
        telescope-nvim
        todo-comments-nvim
        nvim-tree-lua
        telescope-fzf-native-nvim
        vim-tmux-navigator
        # nvim-dap
        # nvim-dap-ui
      ];
      extraConfig = ''
        set noemoji
        nnoremap : <cmd>FineCmdline<CR>
      '';
      extraLuaConfig = # lua
        ''
          ${builtins.readFile ./nvim/options.lua}
          ${builtins.readFile ./nvim/keymaps.lua}
          ${builtins.readFile ./nvim/plugins/colorscheme.lua}
          ${builtins.readFile ./nvim/plugins/alpha.lua}
          ${builtins.readFile ./nvim/plugins/autopairs.lua}
          ${builtins.readFile ./nvim/plugins/auto-session.lua}
          ${builtins.readFile ./nvim/plugins/comment.lua}
          ${builtins.readFile ./nvim/plugins/cmp.lua}
          ${builtins.readFile ./nvim/plugins/new-lsp.lua}
          ${builtins.readFile ./nvim/plugins/nvim-tree.lua}
          ${builtins.readFile ./nvim/plugins/telescope.lua}
          ${builtins.readFile ./nvim/plugins/todo-comments.lua}
          ${builtins.readFile ./nvim/plugins/treesitter.lua}
          ${builtins.readFile ./nvim/plugins/fine-cmdline.lua}
          ${builtins.readFile ./nvim/plugins/bufferline.lua}
          ${builtins.readFile ./nvim/plugins/whichkey.lua}
          ${builtins.readFile ./nvim/plugins/obsidian.lua}
          ${builtins.readFile ./nvim/plugins/none.lua}
          ${builtins.readFile ./nvim/plugins/lualine.lua}
          ${builtins.readFile ./nvim/plugins/presence.lua}
          ${builtins.readFile ./nvim/plugins/copilot.lua}
          require("ibl").setup()
          require("colorizer").setup()
        '';
    };
  };
}
