local g = vim.g
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

return {
  {
    lazy = true,
    "github/copilot.vim",
    event = { "InsertEnter", "CursorHold" },
    config = function()
      local keymap_opt = { noremap = true, script = true, expr = true, silent = true, replace_keycodes = false }
      vim.keymap.set("i", "<C-l>", "copilot#Accept()", keymap_opt)
      g.copilot_no_tab_map = true
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
  },
}
