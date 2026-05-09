{
  programs.nixvim.extraConfigLua = ''
    local opt = vim.opt
    vim.loader.enable()
    opt.number = true
    opt.relativenumber = true
    opt.tabstop = 2
    opt.shiftwidth = 2
    opt.softtabstop = 2
    opt.expandtab = true
    opt.autoindent = true
    opt.wrap = true
    opt.whichwrap = "b,s,<,>,[,],h,l"
    opt.fillchars = "eob: "
    opt.ignorecase = true
    opt.smartcase = true
    opt.termguicolors = true
    opt.background = "dark"
    opt.signcolumn = "yes"
    opt.mouse = "a"
    opt.cursorline = true
    opt.backspace = "indent,eol,start"
    opt.clipboard:append("unnamedplus")
    opt.splitright = true
    opt.splitbelow = true
    opt.swapfile = false
    opt.hidden = true
    opt.hlsearch = false
    opt.scrolloff = 3
    opt.sidescrolloff = 5
    vim.g.mapleader = " "
    opt.conceallevel = 2
    opt.termguicolors = true
    opt.showmode = false

    opt.lazyredraw = true
    opt.synmaxcol = 240
    opt.updatetime = 250
    opt.timeoutlen = 300
    opt.redrawtime = 1500
    opt.hidden = true

    vim.g.loaded_gzip = 1
    vim.g.loaded_matchit = 1
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_tarPlugin = 1
    vim.g.loaded_zipPlugin = 1
    vim.g.loaded_2html_plugin = 1
    vim.g.loaded_remote_plugins = 1
  '';
}
