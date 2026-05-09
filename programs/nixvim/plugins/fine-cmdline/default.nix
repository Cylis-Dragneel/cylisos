{
  programs.nixvim.extraConfigLua = ''
    require('fine-cmdline').setup({
      cmdline = {
        enable_keymaps = true,
        smart_history = true,
        prompt = '> '
      },
      popup = {
        position = {
          row = '10%',
          col = '50%',
        },
        size = {
          width = '60%',
        },
        border = {
          style = 'rounded',
        },
        win_options = {
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
        },
      },
      hooks = {
        before_mount = function(input)
        end,
        after_mount = function(input)
        end,
        set_keymaps = function(imap, feedkeys)
        end
      }
    })
  '';
}
