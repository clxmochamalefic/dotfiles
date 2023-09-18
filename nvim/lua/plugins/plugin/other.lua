local utils = require('utils')

local g = vim.g
local o = vim.o
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

return {
  {
    'glacambre/firenvim',

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    build = function()
      --require("lazy").load({ plugins = "firenvim", wait = true })
      utils.io.echo("shell: " .. o.shell)
      vim.fn["firenvim#install"](0)
    end
  },
}
