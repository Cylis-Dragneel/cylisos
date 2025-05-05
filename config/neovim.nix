{
  pkgs,
  inputs,
  ...
}:
let
  fine-cmdline = pkgs.vimUtils.buildVimPlugin {
    name = "fine-cmdline";
    src = inputs.fine-cmdline;
  };
in
{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = false;
      vimAlias = false;
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
        # Debugging
        delve
        # Formatters
        rustfmt
        clippy
        gofumpt
        golines
        goimports-reviser
        stylua
        prettierd
        nixfmt-rfc-style
        ruff
      ];
      plugins = with pkgs.vimPlugins; [
        # Colorschemes
        tokyonight-nvim
        catppuccin-vim
        rose-pine
        smart-open-nvim
        neocord
        # AI
        copilot-vim
        codecompanion-nvim
        # LSP/Formatting/Completion
        conform-nvim
        none-ls-nvim
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        luasnip
        cmp_luasnip
        friendly-snippets
        lspkind-nvim
        nvim-lspconfig
        vim-wakatime
        mini-nvim
        obsidian-nvim
        nvim-colorizer-lua
        alpha-nvim
        auto-session
        which-key-nvim
        bufferline-nvim
        dressing-nvim
        indent-blankline-nvim
        nui-nvim
        fine-cmdline
        nvim-treesitter.withAllGrammars
        lualine-nvim
        nvim-autopairs
        nvim-web-devicons
        comment-nvim
        nvim-ts-context-commentstring
        plenary-nvim
        telescope-nvim
        todo-comments-nvim
        nvim-tree-lua
        telescope-fzf-native-nvim
        vim-tmux-navigator
        # Debugging
        nvim-dap
        nvim-dap-ui
        nvim-dap-go
        nvim-dap-virtual-text
        persistent-breakpoints-nvim
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
          ${builtins.readFile ./nvim/plugins/auto-session.lua}
          ${builtins.readFile ./nvim/plugins/autopairs.lua}
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
          ${builtins.readFile ./nvim/plugins/conform.lua}
          ${builtins.readFile ./nvim/plugins/lualine.lua}
          ${builtins.readFile ./nvim/plugins/presence.lua}
          ${builtins.readFile ./nvim/plugins/copilot.lua}
          ${builtins.readFile ./nvim/plugins/debugging.lua}
          require("ibl").setup()
          require("colorizer").setup()
        '';
    };
  };
}
