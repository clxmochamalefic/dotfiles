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
}
