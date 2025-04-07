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
require("tokyonight").setup({
  style = "storm",
  transparent = true,
  styles = {
    comments = { italic = true },
    conditionals = { italic = true },
    loops = {},
    functions = { italic = true },
    keywords = { italic = true },
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  lualine_bold = false,
})
vim.cmd([[colorscheme tokyonight-storm]])
