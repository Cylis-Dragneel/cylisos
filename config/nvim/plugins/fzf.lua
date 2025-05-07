-- nvim/plugins/fzf.lua
local fzf = require("fzf-lua")

fzf.setup({
	winopts = {
		height = 0.85,
		width = 0.80,
		row = 0.35,
		col = 0.50,
		border = "rounded",
		preview = {
			border = "rounded",
			wrap = "nowrap",
			hidden = "nohidden",
			vertical = "down:45%",
			horizontal = "right:60%",
			layout = "flex",
			flip_columns = 120,
			title = true,
			title_pos = "center",
		},
	},
	keymap = {
		builtin = {
			["<C-d>"] = "preview-page-down",
			["<C-u>"] = "preview-page-up",
			["<C-n>"] = "next-history",
			["<C-p>"] = "prev-history",
		},
	},
	fzf_opts = {
		-- options are sent as --option=value
		["--layout"] = "reverse",
		["--info"] = "inline",
		["--height"] = "100%",
	},
	files = {
		prompt = "Files❯ ",
		cmd = "fd --type f --hidden --exclude .git --exclude node_modules --exclude .obsidian --exclude .direnv",
		git_icons = true,
		file_icons = true,
		color_icons = true,
	},
	grep = {
		prompt = "Grep❯ ",
		input_prompt = "Grep For❯ ",
		git_icons = true,
		file_icons = true,
		color_icons = true,
		rg_opts = "--hidden --column --line-number --no-heading "
			.. "--color=always --smart-case -g '!.git/' -g '!node_modules/'",
	},
})

-- Key mappings
vim.keymap.set("n", "<leader>fb", function()
	fzf.buffers()
end, { desc = "Find open buffers" })
vim.keymap.set("n", "<leader>fh", function()
	fzf.help_tags()
end, { desc = "Find help for commands" })
vim.keymap.set("n", "<leader>fo", function()
	fzf.oldfiles()
end, { desc = "Open recent files" })

-- Update Obsidian integration
vim.keymap.set("n", "<leader>os", function()
	fzf.files({ cwd = "~/Documents/Main/04 - Main Notes" })
end, { desc = "Find Note" })

vim.keymap.set("n", "<leader>oz", function()
	fzf.live_grep({ cwd = "~/Documents/Main/04 - Main Notes" })
end, { desc = "Live grep in Notes" })

vim.keymap.set("n", "<leader>ors", function()
	fzf.files({ cwd = "~/Documents/Main/01 - Rough Notes" })
end, { desc = "Find Note For Review" })

vim.keymap.set("n", "<leader>orz", function()
	fzf.live_grep({ cwd = "~/Documents/Main/01 - Rough Notes" })
end, { desc = "Live grep in Rough Notes" })

-- Replace the vim.cmd command for telescope
vim.cmd([[command! -nargs=0 GoToFile :lua require('fzf-lua').oldfiles()]])
