{
  programs.nixvim.keymaps = [
    {
      mode = "i";
      key = "jk";
      action = "<ESC>";
      options.desc = "Exit insert mode with jk";
    }
    {
      mode = "i";
      key = "kj";
      action = "<ESC>";
      options.desc = "Exit insert mode with kj";
    }
    {
      mode = "n";
      key = "<leader>nh";
      action = ":nohl<CR>";
      options.desc = "Clear search highlights";
    }
    {
      mode = "n";
      key = "<leader>sv";
      action = "<C-w>v";
      options.desc = "Split window vertically";
    }
    {
      mode = "n";
      key = "<leader>sh";
      action = "<C-w>s";
      options.desc = "Split window horizontally";
    }
    {
      mode = "n";
      key = "<leader>se";
      action = "<C-w>=";
      options.desc = "Make splits equal size";
    }
    {
      mode = "n";
      key = "<leader>x";
      action = "<cmd>BufferLinePickClose<CR>";
      options.desc = "Close current split";
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "<cmd>TmuxNavigateLeft<CR>";
      options.desc = "Go Left";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<cmd>TmuxNavigateRight<CR>";
      options.desc = "Go Right";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<cmd>TmuxNavigateUp<CR>";
      options.desc = "Go Up";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<cmd>TmuxNavigateDown<CR>";
      options.desc = "Go Down";
    }
    {
      mode = "v";
      key = ">";
      action = ">gv";
    }
    {
      mode = "v";
      key = "<";
      action = "<gv";
    }
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
      options = {
        silent = true;
        desc = "Allow <C-d> and <C-u> to keep the cursor in the middle";
      };
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
      options = {
        silent = true;
        desc = "Allow C-d and C-u to keep the cursor in the middle";
      };
    }
    {
      mode = "i";
      key = "<Tab>";
      action = "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'";
      options = {
        expr = true;
        silent = true;
      };
    }
    {
      mode = "s";
      key = "<Tab>";
      action = "<cmd>lua require('luasnip').jump(1)<CR>";
      options.silent = true;
    }
    {
      mode = "i";
      key = "<S-Tab>";
      action = "<cmd>lua require('luasnip').jump(-1)<CR>";
      options.silent = true;
    }
    {
      mode = "s";
      key = "<S-Tab>";
      action = "<cmd>lua require('luasnip').jump(-1)<CR>";
      options.silent = true;
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<C-a>";
      action = "<cmd>CodeCompanionActions<cr>";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>a";
      action = "<cmd>CodeCompanionChat Toggle<cr>";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "v";
      key = "ga";
      action = "<cmd>CodeCompanionChat Add<cr>";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>wr";
      action = "<cmd>SessionRestore<CR>";
      options.desc = "Restore session for cwd";
    }
    {
      mode = "n";
      key = "<leader>ws";
      action = "<cmd>SessionSave<CR>";
      options.desc = "Save session for auto session root dir";
    }
  ];

  programs.nixvim.extraConfigLua = ''
    vim.cmd([[cab cc CodeCompanion]])

    vim.keymap.set("n", "<leader>ll", function()
      local current_config = vim.diagnostic.config()
      if current_config.virtual_text then
        vim.diagnostic.config({
          virtual_text = false,
          virtual_lines = { current_line = true },
        })
      else
        vim.diagnostic.config({
          virtual_text = { current_line = true },
          virtual_lines = false,
        })
      end
    end, { desc = "Toggle between virtual and inline diagnostics" })
  '';
}
