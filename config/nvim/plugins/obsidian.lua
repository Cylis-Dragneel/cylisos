local obsidian = require("obsidian")
obsidian.setup({
	workspaces = {
		{
			name = "main",
			path = "~/Documents/Main",
		},
	},
	notes_subdir = "01 - Rough Notes",
	daily_notes = {
		folder = "notes/dailies",
		date_format = "%d.%mmm.%Y",
		template = "Daily Note.md",
	},
	completion = {
		nvim_cmp = true,
		min_chars = 3,
	},
	mappings = {
		["gf"] = {
			action = function()
				return obsidian.util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		},
		["<leader>oc"] = {
			action = function()
				return obsidian.util.toggle_checkbox()
			end,
			opts = { buffer = true },
		},
		["<cr>"] = {
			action = function()
				return obsidian.util.smart_action()
			end,
			opts = { buffer = true, expr = true },
		},
	},
	new_notes_location = "01 - Rough Notes",
	templates = {
		folder = "06 - Templates",
		date_format = "%d.%b.%Y",
		time_format = "%H.%M",
		substitutions = {},
	},
	picker = {
		name = "telescope.nvim",
		note_mappings = {
			new = "<C-x>",
			insert_link = "<C-l>",
		},
	},
	ui = {
		enable = true, -- set to false to disable all additional syntax features
		update_debounce = 200, -- update delay after a text change (in milliseconds)
		max_file_length = 5000, -- disable UI features for files with more than this many lines
		-- Define how various check-boxes are displayed
		checkboxes = {
			-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
			[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
			["x"] = { char = "", hl_group = "ObsidianDone" },
			[">"] = { char = "", hl_group = "ObsidianRightArrow" },
			["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
			["!"] = { char = "", hl_group = "ObsidianImportant" },
			-- Replace the above with this if you don't have a patched font:
			-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
			-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

			-- You can also add more custom ones...
		},
		-- Use bullet marks for non-checkbox lists.
		bullets = { char = "•", hl_group = "ObsidianBullet" },
		external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
		-- Replace the above with this if you don't have a patched font:
		-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
		reference_text = { hl_group = "ObsidianRefText" },
		highlight_text = { hl_group = "ObsidianHighlightText" },
		tags = { hl_group = "ObsidianTag" },
		block_ids = { hl_group = "ObsidianBlockID" },
		hl_groups = {
			-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
			ObsidianTodo = { bold = true, fg = "#f78c6c" },
			ObsidianDone = { bold = true, fg = "#89ddff" },
			ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
			ObsidianTilde = { bold = true, fg = "#ff5370" },
			ObsidianImportant = { bold = true, fg = "#d73128" },
			ObsidianBullet = { bold = true, fg = "#89ddff" },
			ObsidianRefText = { underline = true, fg = "#c792ea" },
			ObsidianExtLinkIcon = { fg = "#c792ea" },
			ObsidianTag = { italic = true, fg = "#89ddff" },
			ObsidianBlockID = { italic = true, fg = "#89ddff" },
			ObsidianHighlightText = { bg = "#75662e" },
		},
	},
})
-- vim.keymap.set("n", "<leader>of", ":%s/^# \\d\\{2}-\\d\\{2}-\\d\\{4} - \\(\\w\\+\\)/# \\u\\1/<cr>", { desc = "Format Title" })
vim.keymap.set("n", "<leader>of", ":%s/^# \\(\\w\\+\\)/# \\u\\1/<cr>", { desc = "Format Title" })
vim.keymap.set("n", "<leader>on", ":ObsidianTemplate New Note<cr>", { desc = "Use New Note Template" })
vim.keymap.set(
	"n",
	"<leader>omk",
	":!mv '%:p' '/home/cylis/Documents/Main/04 - Main Notes'<cr>:bd<cr>",
	{ desc = "Move Note to Main Notes" }
)
vim.keymap.set(
	"n",
	"<leader>omp",
	":!mv '%:p' '/home/cylis/Documents/Main/02 - Projects'<cr>:bd<cr>",
	{ desc = "Move Note to Projects" }
)
vim.keymap.set(
	"n",
	"<leader>oms",
	":!mv '%:p' '/home/cylis/Documents/Main/03 - Source Material'<cr>:bd<cr>",
	{ desc = "Move Note to Source Material" }
)
vim.keymap.set(
	"n",
	"<leader>omt",
	":!mv '%:p' '/home/cylis/Documents/Main/05 - Tags'<cr>:bd<cr>",
	{ desc = "Move Tag" }
)
vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>", { desc = "Delete currently open file" })
vim.keymap.set("n", "<leader>os", function()
	require("telescope.builtin").find_files({
		prompt_title = "Find Notes",
		cwd = "~/Documents/Main/04 - Main Notes",
	})
end, { desc = "Find Note" })
vim.keymap.set("n", "<leader>oz", function()
	require("telescope.builtin").live_grep({
		prompt_title = "Find in Notes",
		cwd = "~/Documents/Main/04 - Main Notes",
	})
end, { desc = "Live grep in Notes" })
vim.keymap.set("n", "<leader>ors", function()
	require("telescope.builtin").find_files({
		prompt_title = "Find Notes",
		cwd = "~/Documents/Main/01 - Rough Notes",
	})
end, { desc = "Find Note For Review" })
vim.keymap.set("n", "<leader>orz", function()
	require("telescope.builtin").live_grep({
		prompt_title = "Find in Rough Notes",
		cwd = "~/Documents/Main/01 - Rough Notes",
	})
end, { desc = "Live grep in Rough Notes" })
