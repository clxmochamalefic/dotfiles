-- ---------------------------------------------------------------------------
--  UI WINDOW PLUGINS
-- ---------------------------------------------------------------------------

local g = vim.g
local fn = vim.fn
local uv = vim.uv
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local myWinPick = require("plugins.plugin.config.winpick")

return {
  -- {
  --   't9md/vim-choosewin',
  --   init = function()
  --     vim.keymap.set("n", "-", "<Plug>(choosewin)")
  --   end
  -- },
  {
    'gbrlsnchs/winpick.nvim',
    cmd = { "WinPick", },
    keys = {
      { "-", "<cmd>WinPick<CR>", mode = "n" },
    },
    init = function()
      myWinPick.setup({})
    end,
    config = function()
      api.nvim_create_user_command("WinPick", myWinPick.choose_for_focus, {})
      vim.keymap.set("n", "-", myWinPick.choose_for_focus)
    end
  },
}
