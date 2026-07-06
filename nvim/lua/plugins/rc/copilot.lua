-- ---------------------------------------------------------------------------
-- AI PLUGINS
-- ---------------------------------------------------------------------------

return {
  {
    lazy = true,
    "github/copilot.vim",
    event = {
      "VeryLazy",
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
      vim.keymap.set("i", "<C-j>", "copilot#Accept()", keymap_opt)
      --vim.keymap.set("i", "<C-Enter>", "copilot#Accept()", keymap_opt)
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    lazy = true,
    "CopilotC-Nvim/CopilotChat.nvim",
    event = {
      "VeryLazy",
      "FileReadPost",
    },
    build = "make tiktoken",
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
