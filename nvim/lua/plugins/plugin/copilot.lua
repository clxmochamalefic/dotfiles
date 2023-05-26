local g = vim.g
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

return {
 {
   'github/copilot.vim',
   lazy = true,
   event = 'InsertEnter'
  }
}
