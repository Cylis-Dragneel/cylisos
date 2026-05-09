{
  programs.nixvim.extraConfigLua = ''
    local obsidian = require("obsidian")
    obsidian.setup({
      legacy_commands = false,
      workspaces = {
        {
          name = "main",
          path = "~/Documents/Main",
        },
      },
      notes_subdir = "01 - Rough Notes",
      daily_notes = {
        folder = "notes/dailies",
        date_format = "%d.%mmm.%Y",
        template = "Daily Note.md",
      },
      completion = {
        nvim_cmp = true,
        min_chars = 3,
      },
      new_notes_location = "01 - Rough Notes",
      templates = {
        folder = "06 - Templates",
        date_format = "%d.%b.%Y",
        time_format = "%H.%M",
        substitutions = {},
      },
      picker = {
        name = "fzf-lua",
        note_mappings = {
          new = "<C-x>",
          insert_link = "<C-l>",
        },
      },
      ui = {
        enable = true,
        update_debounce = 200,
        max_file_length = 5000,
        checkboxes = {
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
        },
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = require("rose-pine.plugins.obsidian"),
      },
    })

    vim.keymap.set("n", "<leader>of", ":%s/^# \\(\\w\\+\\)/# \\u\\1/<cr>", { desc = "Format Title" })
    vim.keymap.set("n", "<leader>on", ":Obsidian Template New Note<cr>", { desc = "Use New Note Template" })
    vim.keymap.set(
      "n",
      "<leader>omk",
      ":!mv '%:p' '/home/cylis/Documents/Main/04 - Main Notes'<cr>:bd<cr>",
      { desc = "Move Note to Main Notes" }
    )
    vim.keymap.set(
      "n",
      "<leader>omp",
      ":!mv '%:p' '/home/cylis/Documents/Main/02 - Projects'<cr>:bd<cr>",
      { desc = "Move Note to Projects" }
    )
    vim.keymap.set(
      "n",
      "<leader>oms",
      ":!mv '%:p' '/home/cylis/Documents/Main/03 - Source Material'<cr>:bd<cr>",
      { desc = "Move Note to Source Material" }
    )
    vim.keymap.set(
      "n",
      "<leader>omt",
      ":!mv '%:p' '/home/cylis/Documents/Main/05 - Tags'<cr>:bd<cr>",
      { desc = "Move Tag" }
    )
    vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>", { desc = "Delete currently open file" })
    vim.keymap.set("n", "gf", function() return obsidian.util.gf_passthrough() end, {})
    vim.keymap.set("n", "<leader>oc", function() return obsidian.util.toggle_checkbox() end, {})
    vim.keymap.set("n", "<cr>", function() return obsidian.util.smart_action() end, {})
  '';
}
