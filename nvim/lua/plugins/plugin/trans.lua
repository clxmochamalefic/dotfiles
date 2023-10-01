local g = vim.g
local fn = vim.fn
local uv = vim.uv
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local myWinPick = require("plugins.plugin.individual.winpick")
local utils = require("utils")

local myDenops = require("plugins.plugin.individual.denops")

return {
  {
    lazy = true,
    'uga-rosa/translate.nvim',
    event = { 'BufEnter' },
    config = function()
      require("translate").setup({})
    end,
  },
}
