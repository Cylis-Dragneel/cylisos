local cmp = require("cmp")
local ls = require("luasnip")
local lspkind = require("lspkind")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

require("luasnip.loaders.from_vscode").lazy_load()
ls.add_snippets("go", {
  s("errf", {
    t("if err != nil {"),
    t({ "", '\tlog.Fatal("Error: ", err)' }),
    t({ "", "}" }),
  }),
})

cmp.setup({
  completion = {
    completeopt = "menu,menuone,preview,noselect",
  },
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    --[[ ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion ]]
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = 50,
      ellipsis_char = "...",
      symbol_map = { Codecompanion = "" },
    }),
  },
})
