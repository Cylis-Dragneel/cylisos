require("markdown").setup({
	mappings = {
		inline_surround_toggle = "gs", -- (string|boolean) toggle inline style
		inline_surround_toggle_line = "gss", -- (string|boolean) line-wise toggle inline style
		inline_surround_delete = "ds", -- (string|boolean) delete emphasis surrounding cursor
		inline_surround_change = "cs", -- (string|boolean) change emphasis surrounding cursor
		link_add = "gl", -- (string|boolean) add link
		link_follow = "gx", -- (string|boolean) follow link
		go_curr_heading = "]c", -- (string|boolean) set cursor to current section heading
		go_parent_heading = "]p", -- (string|boolean) set cursor to parent section heading
		go_next_heading = "]]", -- (string|boolean) set cursor to next section heading
		go_prev_heading = "[[", -- (string|boolean) set cursor to previous section heading
	},
	inline_surround = {
		-- For the emphasis, strong, strikethrough, and code fields:
		-- * 'key': used to specify an inline style in toggle, delete, and change operations
		-- * 'txt': text inserted when toggling or changing to the corresponding inline style
		emphasis = {
			key = "i",
			txt = "*",
		},
		strong = {
			key = "b",
			txt = "**",
		},
		strikethrough = {
			key = "s",
			txt = "~~",
		},
		code = {
			key = "c",
			txt = "`",
		},
	},
	link = {
		paste = {
			enable = true, -- whether to convert URLs to links on paste
		},
	},
	toc = {
		-- Comment text to flag headings/sections for omission in table of contents.
		omit_heading = "toc omit heading",
		omit_section = "toc omit section",
		-- Cycling list markers to use in table of contents.
		-- Use '.' and ')' for ordered lists.
		markers = { "-" },
	},
	-- Hook functions allow for overriding or extending default behavior.
	-- Called with a table of options and a fallback function with default behavior.
	-- Signature: fun(opts: table, fallback: fun())
	hooks = {
		-- Called when following links. Provided the following options:
		-- * 'dest' (string): the link destination
		-- * 'use_default_app' (boolean|nil): whether to open the destination with default application
		--   (refer to documentation on <Plug> mappings for explanation of when this option is used)
		follow_link = nil,
	},
	on_attach = nil, -- (fun(bufnr: integer)) callback when plugin attaches to a buffer
})

vim.keymap.set("n", "<leader>mt", ":MDTaskToggle<CR>", { desc = "Toggle Task status in markdown" })

require("clipboard-image").setup({
	-- Default configuration for all filetype
	default = {
		img_dir = "images",
		img_name = function()
			return os.date("%Y-%m-%d-%H-%M-%S")
		end, -- Example result: "2021-04-13-10-04-18"
		affix = "<\n  %s\n>", -- Multi lines affix
	},
	-- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
	-- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
	-- Missing options from `markdown` field will be replaced by options from `default` field
	markdown = {
		img_dir = { "public", "blog", "img" }, -- Use table for nested dir (New feature form PR #20)
		img_dir_txt = "img",
		img_handler = function(img) -- New feature from PR #22
			local script = string.format('./image_compressor.sh "%s"', img.path)
			os.execute(script)
		end,
	},
})
vim.keymap.set("n", "<leader>mi", ":PasteImg<CR>", { desc = "Paste image in markdown" })
