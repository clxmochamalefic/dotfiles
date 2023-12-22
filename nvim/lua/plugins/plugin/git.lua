local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

return {
  {
    lazy = true,
    'lambdalisue/gin.vim',
    event = { 'BufRead', 'FileReadPost' },
    dependencies = {
      'vim-denops/denops.vim'
    },
  },
  {
    lazy = true,
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    event = { 'BufRead', 'FileReadPost' },
    cmd = {
      'Neogit',
    },
    keys = {
      { "<leader>g", "<cmd>Neogit cwd=%:p:h<CR>", mode = "n" },
    },
    config = function()
      local neogit = require('neogit')
      neogit.setup {}
    end,
  },
}

