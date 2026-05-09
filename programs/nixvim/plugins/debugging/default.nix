{
  programs.nixvim.extraConfigLua = ''
    local dap = require("dap")
    local dapui = require("dapui")

    require("dap-go").setup()
    dapui.setup()
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      all_references = false,
      virt_text_pos = "eol",
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil,
    })
    require("persistent-breakpoints").setup({
      load_breakpoints_event = { "BufReadPost" },
    })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "", linehl = "", numhl = "" })

    vim.keymap.set("n", "<leader>dt", require("persistent-breakpoints.api").toggle_breakpoint)
    vim.keymap.set("n", "<leader>dc", dap.continue)
    vim.keymap.set("n", "<leader>du", dapui.toggle)
    vim.keymap.set("n", "<leader>dn", dap.step_over)
  '';
}
