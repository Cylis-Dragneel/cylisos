-- require("catppuccin").setup({
-- 	flavour = "macchiato",
-- 	background = {
-- 		light = "latte",
-- 		dark = "macchiato",
-- 	},
-- 	transparent_background = true,
-- 	show_end_of_buffer = false,
-- 	styles = {
-- 		comments = { "italic" },
-- 		conditionals = { "italic" },
-- 		loops = {},
-- 		functions = { "italic" },
-- 		keywords = { "italic" },
-- 		strings = {},
-- 		variables = {},
-- 		numbers = {},
-- 		booleans = {},
-- 		properties = {},
-- 		types = {},
-- 		operators = {},
-- 		-- miscs = {}, -- Uncomment to turn off hard-coded styles
-- 	},
-- 	color_overrides = {},
-- 	custom_highlights = {},
-- 	default_integrations = true,
-- 	integrations = {
-- 		neotree = true,
-- 		which_key = true,
-- 	},
-- })
-- require("tokyonight").setup({
--   style = "storm",
--   transparent = true,
--   styles = {
--     comments = { italic = true },
--     conditionals = { italic = true },
--     loops = {},
--     functions = { italic = true },
--     keywords = { italic = true },
--     strings = {},
--     variables = {},
--     numbers = {},
--     booleans = {},
--     properties = {},
--     types = {},
--     operators = {},
--   },
--   lualine_bold = false,
-- })

require("rose-pine").setup({
	variant = "moon",
	dim_inactive_windows = false,
	disable_background = true,
	extended_background_behind_borders = false,
	enable = {
		terminal = true,
	},
	styles = {
		bold = true,
		italic = true,
		transparency = true,
	},
	highlight_groups = {
		TelescopeBorder = { fg = "highlight_high", bg = "none" },
		TelescopeNormal = { bg = "none" },
		TelescopePromptNormal = { bg = "none" },
		TelescopeResults = { fg = "subtle", bg = "none" },
		TelescopeResultsNormal = { fg = "subtle", bg = "none" },
		TelescopePreview = { fg = "text", bg = "none" },
		TelescopePreviewNormal = { fg = "text", bg = "none" },
		TelescopeSelection = { fg = "text", bg = "none" },
		TelescopeSelectionCaret = { fg = "rose", bg = "none" },
		StatusLine = { fg = "love", bg = "love", blend = 10 },
		StatusLineNC = { fg = "subtle", bg = "surface" },
	},
})

vim.cmd([[colorscheme rose-pine-moon]])
