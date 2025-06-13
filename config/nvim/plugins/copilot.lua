vim.g.copilot_filetypes = {
	markdown = false,
}
vim.g.copilot_enabled = 0
vim.api.nvim_create_user_command("CopilotStart", function()
	vim.cmd("LspRestart copilot")
end, {})

vim.api.nvim_create_user_command("CopilotStop", function()
	-- Stop copilot LSP client
	local clients = vim.lsp.get_clients({ name = "copilot" })
	for _, client in ipairs(clients) do
		client.stop(client)
	end
end, {})

require("codecompanion").setup({
	adapters = {
		sonnet3 = function()
			return require("codecompanion.adapters").extend("copilot", {
				schema = {
					model = {
						default = "claude-3.5-sonnet",
					},
				},
			})
		end,
		sonnet4 = function()
			return require("codecompanion.adapters").extend("copilot", {
				schema = {
					model = {
						default = "claude-sonnet-4",
					},
				},
			})
		end,
		gemni = function()
			return require("codecompanion.adapters").extend("copilot", {
				schema = {
					model = {
						default = "gemini-2.5-pro",
					},
				},
			})
		end,
	},
	strategies = {
		chat = { adapter = "sonnet4" },
		inline = { adapter = "gemni" },
		agent = { adapter = "sonnet3" },
	},
})
