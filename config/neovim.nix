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
        conform-nvim # none-ls replacement
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        luasnip
        cmp_luasnip
        friendly-snippets
        lspkind-nvim
        nvim-lspconfig
        vim-wakatime
        obsidian-nvim
        nvim-colorizer-lua # Color previews
        alpha-nvim # Dashboard
        auto-session # Remembering open files
        which-key-nvim
        bufferline-nvim
        lualine-nvim
        indent-blankline-nvim
        fine-cmdline
        (nvim-treesitter.withPlugins (
          plugins: with plugins; [
            bash
            c
            go
            html
            javascript
            json
            lua
            markdown
            nix
            python
            rust
            toml
            typescript
            vim
            yaml
            zig
          ]
        ))
        mini-pairs
        nvim-web-devicons
        comment-nvim
        nvim-ts-context-commentstring
        fzf-lua # replacing telescope
        todo-comments-nvim
        oil-nvim # replacing nvim-tree
        telescope-fzf-native-nvim
        vim-tmux-navigator
        # Debugging
        nvim-dap
        nvim-dap-ui
        nvim-dap-go
        nvim-dap-virtual-text
        persistent-breakpoints-nvim
        # Dependencies
        plenary-nvim
        nui-nvim
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
          ${builtins.readFile ./nvim/plugins/oil.lua}
          ${builtins.readFile ./nvim/plugins/fzf.lua}
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
