{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
    lazyLoad.enable = true;
  };

  programs.nixvim.extraConfigLua = ''
    local todo_comments = require("todo-comments")

    vim.keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    vim.keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    vim.keymap.set("n", "<leader>ft", function()
      require("fzf-lua").grep({
        search = "(TODO|HACK|WARNING|NOTE|FIX|BUG|PERF):",
      })
    end, { desc = "Find todos" })
  '';
}
