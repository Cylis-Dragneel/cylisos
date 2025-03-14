require("cord").setup({
	editor = { tooltip = "Coding Hard or Hardly Coding" },
	display = {
		theme = "catppuccin",
		swap_fields = true,
		swap_icons = true,
	},
	idle = { details = "Staring into the void probalby" },
	variables = true,
	advanced = {
		plugin = { cursor_update = "on_move" },
		discord = {
			reconnect = { enabled = true },
		},
	},
	assets = {
		[".lua"] = {
			tooltip = "Lua",
			icon = "http://www.andreas-rozek.de/Lua/Lua-Logo_64x64.png",
		},
		[".nix"] = {
			tooltip = "Nix",
			-- icon = "https://github.com/NixOS/nixos-artwork/blob/master/logo/nix-snowflake-colours.svg",
		},
		[".zig"] = {
			tooltip = "Zig",
			-- icon = "https://github.com/ziglang/logo/blob/master/zig-favicon.png",
		},
	},
})
