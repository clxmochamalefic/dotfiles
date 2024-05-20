local g = vim.g
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

return {
  {
    lazy = true,
    'github/copilot.vim',
    event = { 'InsertEnter', 'CursorHold' },
    config = function()
      g.copilot_no_maps = true
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { 'github/copilot.vim' }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
  },
}
