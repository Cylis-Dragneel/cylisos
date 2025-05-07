local todo_comments = require("todo-comments")

-- set keymaps
local keymap = vim.keymap -- for conciseness

keymap.set("n", "]t", function()
	todo_comments.jump_next()
end, { desc = "Next todo comment" })

keymap.set("n", "[t", function()
	todo_comments.jump_prev()
end, { desc = "Previous todo comment" })

keymap.set("n", "<leader>ft", function()
	require("fzf-lua").grep({
		search = "(TODO|HACK|WARNING|NOTE|FIX|BUG|PERF):",
	})
end, { desc = "Find todos" })

todo_comments.setup()
