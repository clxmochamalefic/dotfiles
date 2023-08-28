local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

return {
  {
    lazy = true,
    'lambdalisue/gin.vim',
    dependencies = {
      'vim-denops/denops.vim'
    },
    event = { 'BufRead', 'FileReadPost' },
  },
}

