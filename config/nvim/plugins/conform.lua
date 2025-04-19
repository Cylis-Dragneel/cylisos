local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", "clippy", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		javascript = { "prettierd", "prettier", stop_after_first = true },
		go = { "gofumpt", "goimports_reviser", "golines" },
		nix = { "nixfmt" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})
