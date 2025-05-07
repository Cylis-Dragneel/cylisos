local wk = require("which-key")
wk.add({
	{ "<leader>Q", "<cmd>q!<CR>", desc = "Quit without saving" },
	{ "<leader>W", "<cmd>w<CR>", desc = "Write" },
	{ "<leader>e", "<cmd>Oil<CR>", desc = "File Explorer" },
	{ "<leader>f", group = "FZF" },
	{
		"<leader>ff",
		function()
			require("fzf-lua").files()
		end,
		desc = "Find Files",
	},
	{
		"<leader>fr",
		function()
			require("fzf-lua").live_grep()
		end,
		desc = "Live Grep",
	},
	{ "<leader>l", group = "LSP" },
	{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Connected Language Servers" },
	{ "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format buffer" },
	{ "<leader>q", "<cmd>q<CR>", desc = "Quit" },
	{ "<leader>rn", "<cmd>set relativenumber<CR>", desc = "Turn on relative numbers" },
	{ "<leader>x", "<cmd>bdelete<CR>", desc = "Close Buffer" },
	{ "<leader>o", group = "Obsidian" },
	{ "<leader>om", group = "Move Note" },
	{ "<leader>or", group = "Rough" },
	{ "<leader>s", group = "Splits" },
	{ "<leader>w", group = "Sessions" },
})
