require("telescope").setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			vertical = {
				preview_cutoff = 0,
				preview_position = "top",
				prompt_position = "bottom",
				width = 0.9,
				height = 0.9,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		smart_open = {
			show_scores = false,
			ignore_patterns = { "%.git/", "node_modules/" },
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("smart_open")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find open buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help for commands" })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope smart_open<cr>", { desc = "Open Files" })
vim.cmd([[command! -nargs=0 GoToFile :Telescope smart_open]])
