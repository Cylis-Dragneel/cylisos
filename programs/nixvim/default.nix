{ pkgs, ... }:
{
  imports = [
    ./keymaps
    ./options
    ./plugins
  ];

  programs.nixvim = {
    enable = false;
    defaultEditor = false;
    viAlias = false;
    vimAlias = false;
    vimdiffAlias = true;
    withNodeJs = true;
    withRuby = false;
    withPython3 = false;

    extraPackages = with pkgs; [
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
      gopls
      vim-language-server
      bash-language-server
      marksman
      luajitPackages.lua-lsp
      delve
      rustfmt
      clippy
      gofumpt
      golines
      goimports-reviser
      stylua
      prettierd
      nixfmt
      ruff
    ];

    extraConfigVim = ''
      set noemoji
      nnoremap : <cmd>FineCmdline<CR>
    '';
  };
}
