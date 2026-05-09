{
  programs.nixvim.extraConfigLua = ''
    require("markdown").setup({
      mappings = {
        inline_surround_toggle = "gs",
        inline_surround_toggle_line = "gss",
        inline_surround_delete = "ds",
        inline_surround_change = "cs",
        link_add = "gl",
        link_follow = "gx",
        go_curr_heading = "]c",
        go_parent_heading = "]p",
        go_next_heading = "]]",
        go_prev_heading = "[[",
      },
      inline_surround = {
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
          enable = true,
        },
      },
      toc = {
        omit_heading = "toc omit heading",
        omit_section = "toc omit section",
        markers = { "-" },
      },
      hooks = {
        follow_link = nil,
      },
      on_attach = nil,
    })

    vim.keymap.set("n", "<leader>mt", ":MDTaskToggle<CR>", { desc = "Toggle Task status in markdown" })

    require("clipboard-image").setup({
      default = {
        img_dir = "images",
        img_name = function()
          return os.date("%Y-%m-%d-%H-%M-%S")
        end,
        affix = "<\n  %s\n>",
      },
      markdown = {
        img_dir = { "public", "blog", "img" },
        img_dir_txt = "img",
        img_handler = function(img)
          local script = string.format('./image_compressor.sh "%s"', img.path)
          os.execute(script)
        end,
      },
    })
    vim.keymap.set("n", "<leader>mi", ":PasteImg<CR>", { desc = "Paste image in markdown" })
  '';
}
