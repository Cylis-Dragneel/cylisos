require("bufferline").setup({
  highlights = require("rose-pine.plugins.bufferline"),
})
vim.cmd([[
nnoremap <silent><TAB> :BufferLineCycleNext<CR>
nnoremap <silent><S-TAB> :BufferLineCyclePrev<CR>
]])
