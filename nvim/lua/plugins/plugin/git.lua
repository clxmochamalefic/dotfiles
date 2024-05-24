local g = vim.g
local fn = vim.fn
local api = vim.api
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
    tag = "v1.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
      "kevinhwang91/nvim-ufo",
    },
    cmd = {
      "Neogit",
    },
    keys = {
      { "gi", "<cmd>Neogit cwd=%:p:h<CR>", mode = "n" },
    },
    config = true,
    --config = function()
    --  local neogit = require("neogit")
    --  neogit.setup({})
    --end,
  },
  {
    lazy = true,
    "FabijanZulj/blame.nvim",
    event = { "BufRead", "FileReadPost" },
    cmd = {
      "ToggleBlame virtual",
      "ToggleBlameVirtual",
    },
    config = function()
      --local blame = require("blame")
      --blame.setup({ virtual_style = "float" })

      api.nvim_create_user_command("ToggleBlameVirtual", "ToggleBlame virtual", {})
      --api.nvim_create_user_command("ToggleBlameVirtual", "<Cmd>ToggleBlame virtual<CR>", {})
    end,
  },
}
