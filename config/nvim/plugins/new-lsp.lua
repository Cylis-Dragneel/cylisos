local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp = vim.lsp.config
local enable = vim.lsp.enable
local function on_attach(client, bufnr)
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true)
	end
end

local servers = {
	"rustanalyzer",
	"nixd",
	"gopls",
	"vtsls",
	"zls",
	"luals",
	"html",
	"basedpyright",
	"jsonls",
	"yamlls",
	"bashls",
	"marksman",
	"clangd",
	"elixirls",
	"astro",
	"denols",
	"harperls",
}

lsp["rustanalyzer"] = {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		rust_analyzer = {
			check_on_save = true,
			check = { command = "clippy" },
			proc_macro = { enable = true },
			formatting = { command = "rustfmt" },
		},
	},
}

lsp["nixd"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "nixd" },
	filetypes = { "nix" },
	settings = {
		nixd = {
			autowatch = true,
			nixpkgs = { expr = 'import (builtins.getFlake "/home/cylis/cylisos").inputs.nixpkgs { }' },
			formatting = { command = { "nixfmt" } },
			options = {
				nixos = { expr = '(builtins.getFlake "/home/cylis/cylisos/").nixosConfigurations.dragneel.options' },
			},
		},
	},
}

lsp["gopls"] = {
	capabiltes = capabilites,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod" },
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedPArams = true,
			},
		},
	},
}

lsp["vtsls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	cmd = { "vtsls", "--stdio" },
}

lsp["zls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "zig" },
	cmd = { "zls" },
}

lsp["luals"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "lua" },
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
}

lsp["html"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html" },
	cmd = { "html-lsp" },
}

lsp["basedpyright"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "python" },
	cmd = { "basedpyright-langserver", "--stdio" },
}

lsp["jsonls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "json" },
	cmd = { "json-lsp" },
}

lsp["yamlls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "yaml" },
	cmd = { "yaml-language-server", "--stdio" },
}

lsp["bashls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "sh", "bash" },
	cmd = { "bash-language-server", "start" },
}

lsp["marksman"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "markdown" },
	cmd = { "marksman" },
}

lsp["clangd"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "c", "cpp", "objc", "objcpp" },
	cmd = { "clangd" },
}

lsp["elixirls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "elixir" },
	cmd = { "elixir-ls" },
}

lsp["astro"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "astro" },
	cmd = { "astro-ls" },
}

lsp["denols"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "deno" },
	cmd = { "deno", "lsp" },
}

lsp["harperls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "harper-ls", "--stdio" },
	settings = {
		["harper-ls"] = {
			linters = {
				spell_check = true,
				spelled_numbers = false,
				an_a = true,
				sentence_capitalization = true,
				unclosed_quotes = true,
				wrong_quotes = true,
				long_sentences = true,
				repeated_words = true,
				spaces = true,
				matcher = true,
				correct_number_suffix = true,
				number_suffix_capitalization = true,
				multiple_sequential_pronouns = true,
				linking_verbs = true,
				avoid_curses = false,
				terminating_conjuctions = true,
			},
		},
	},
}

for _, server in ipairs(servers) do
	enable(server)
end

vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hovering definition" })
vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Definition" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })

vim.lsp.set_log_level("error")

vim.diagnostic.config({ virtual_text = { current_line = true } })
