local keymap = vim.keymap
-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with kj" })
-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>x", "<cmd>BufferLinePickClose<CR>", { desc = "Close current split" }) -- close current split window
keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Go Left" })
keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Go Right" })
keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Go Up" })
keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Go Down" })
keymap.set("v", ">", ">gv", {})
keymap.set("v", "<", "<gv", {})
keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, desc = "Allow <C-d> and <C-u> to keep the cursor in the middle" })
keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, desc = "Allow C-d and C-u to keep the cursor in the middle" })

vim.api.nvim_set_keymap(
	"i",
	"<Tab>",
	"luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
	{ expr = true, silent = true }
)
vim.api.nvim_set_keymap("s", "<Tab>", "<cmd>lua require('luasnip').jump(1)<CR>", { silent = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "<cmd>lua require('luasnip').jump(-1)<CR>", { silent = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "<cmd>lua require('luasnip').jump(-1)<CR>", { silent = true })

-- vim.g.copilot_no_tab_map = true
-- vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
-- keymap.set(
-- 	"n",
-- 	"<leader>Ct",
-- 	"<cmd>CordTogglePresence<cr>",
-- 	{ noremap = true, silent = true, desc = "Toggle Rich Presence" }
-- )

keymap.set("n", "<leader>ll", function()
	local current_config = vim.diagnostic.config()
	if current_config.virtual_text then
		vim.diagnostic.config({
			virtual_text = false,
			virtual_lines = { current_line = true },
		})
	else
		vim.diagnostic.config({
			virtual_text = { current_line = true },
			virtual_lines = false,
		})
	end
end, { desc = "Toggle between virtual and inline diagnostics" })
