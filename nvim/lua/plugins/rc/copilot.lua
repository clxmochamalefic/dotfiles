local g = vim.g
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

return {
  {
    lazy = true,
    "github/copilot.vim",
    event = {
      "InsertEnter",
    },
    config = function()
      local keymap_opt = {
        noremap = false,
        script = true,
        expr = true,
        silent = true,
        replace_keycodes = false
      }
      vim.keymap.set("i", "<C-\\>", "copilot#Accept()", keymap_opt)
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    lazy = true,
    "CopilotC-Nvim/CopilotChat.nvim",
    event = {
      "FileReadPost",
    },
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      --debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
  },
}
