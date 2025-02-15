-- ---------------------------------------------------------------------------
--  UI WINDOW PLUGINS
-- ---------------------------------------------------------------------------

local winpickConfig = require("plugins.plugin.ui.config.winpick")

local function wp()
  print(require('window-picker').pick_window())
end

return {
  {
    "gbrlsnchs/winpick.nvim",
    cmd = { "WinPick" },
    keys = {
      { "-", "<cmd>WinPick<CR>", mode = "n" },
    },
    config = function()
      winpickConfig.setup()
    end,
  },
  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    --event = { 'VeryLazy' },
    --version = '2.*',
    cmd = { "NvimWindowPicker" },
    keys = {
      --{ "-", "<Cmd>NvimWindowPicker<CR>", mode = "n" },
      --{ "-", wp, mode = "n" },
    },
    opts = {
      filter_rules = {
        include_current_win = true,
        autoselect_one = false,

        -- filter using buffer options
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = { 'neo-tree', "neo-tree-popup", "notify" },
          --filetype = { "neo-tree-popup", "notify" },
          --
          -- if the buffer type is one of following, the window will be ignored
          --buftype = { "quickfix" },
          buftype = { 'terminal', "quickfix" },
        },
      },
      --hint = 'statusline-winbar',
      hint = 'floating-big-letter',
    },
    config = function(_, opts)
      require 'window-picker'.setup(opts)
      vim.api.nvim_create_user_command( "NvimWindowPicker", wp, {})
    end,
  },
}
