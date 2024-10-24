local g = vim.g
local fn = vim.fn
local opt = vim.opt
local keymap = vim.keymap

return {
  {
    lazy = true,
    "lambdalisue/gin.vim",
    event = { "BufRead", "FileReadPost" },
    dependencies = {
      "vim-denops/denops.vim",
    },
  },
  {
    --lazy = true,
    --event = { "BufRead", "FileReadPost" },
    "NeogitOrg/neogit",
    --branch = "nightly",
    --tag = "v1.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
      --"kevinhwang91/nvim-ufo",
    },
    cmd = {
      "Neogit",
    },
    keys = {
      { "gi", "<cmd>Neogit cwd=%:p:h<CR>", mode = "n" },
    },
    --config = true,
    config = function()
      local neogit = require("neogit")
      neogit.setup({})
    end,
  },
  {
    'FabijanZulj/blame.nvim',
    lazy = true,
    event = { "VeryLazy" },
    cmd = {
      'ToggleBlame',
      "ToggleBlameVirtual",
    },
    -- stylua: ignore
    keys = {
      { 'tb', '<cmd>BlameToggle virtual<CR>', desc = 'Git blame' },
      { 'tB', '<cmd>BlameToggle window<CR>', desc = 'Git blame (window)' },
    },
    opts = {
      date_format = '%Y-%m-%d %H:%M',
      merge_consecutive = false,
      max_summary_width = 30,
      mappings = {
        commit_info = 'K',
        stack_push = '>',
        stack_pop = '<',
        show_commit = '<CR>',
        close = { '<Esc>', 'q' },
      },
    },
  },
}
