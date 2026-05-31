{ pkgs, inputs, ... }:
let
  fine-cmdline = pkgs.vimUtils.buildVimPlugin {
    name = "fine-cmdline";
    src = inputs.fine-cmdline;
  };
in
{
  imports = [
    ./alpha
    ./auto-session
    ./autopairs
    ./bufferline
    ./cmp
    ./colorscheme
    ./comment
    ./conform
    ./copilot
    ./debugging
    ./fine-cmdline
    ./fzf
    ./lsp
    ./lualine
    ./markdown
    ./obsidian
    ./oil
    ./presence
    ./snacks
    ./todo-comments
    ./treesitter
    ./which-key
  ];

  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    tokyonight-nvim
    catppuccin-vim
    rose-pine
    neocord
    copilot-vim
    codecompanion-nvim
    fine-cmdline
    markdown-nvim
    markdown-preview-nvim
    clipboard-image-nvim
    nvim-colorizer-lua
    snacks-nvim
    vim-wakatime
  ];
}
