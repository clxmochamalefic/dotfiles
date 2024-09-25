-- ---------------------------------------------------------------------------
--  UI WINDOW PLUGINS
-- ---------------------------------------------------------------------------

local winpickConfig = require("plugins.plugin.ui.config.winpick")

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
}

--return {
--  {
--    's1n7ax/nvim-window-picker',
--    name = 'window-picker',
--    event = 'VeryLazy',
--    version = '2.*',
--    keys = {
--      { "-", "<cmd>WinPick<CR>", mode = "n" },
--    },
--    config = function()
--      require 'window-picker'.setup({
--        filter_rules = {
--          include_current_win = false,
--          autoselect_one = true,
--          -- filter using buffer options
--          bo = {
--            -- if the file type is one of following, the window will be ignored
--            --filetype = { 'neo-tree', "neo-tree-popup", "notify" },
--            filetype = {
--              "neo-tree-popup",
--              "notify",
--            },
--            -- if the buffer type is one of following, the window will be ignored
--            buftype = {
--              'terminal',
--              "quickfix",
--            },
--          },
--        },
--      })
--
--      local function winpick()
--        local picked_window_id = require('window-picker').pick_window()
--      end
--      vim.api.nvim_create_user_command("WinPick", winpick, {})
--    end,
--  }
--}

