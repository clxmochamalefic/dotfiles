local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

return {
  {
    lazy = true,
    depencencies = { 'vim-denops/denops.vim' },
    'lambdalisue/gin.vim',
    event = { 'BufRead', 'FileReadPost' },
  },
}

