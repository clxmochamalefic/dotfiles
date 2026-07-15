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
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    lazy = true,
    config = true,
    -- `cmd` lets lazy.nvim create command stubs that load the plugin on first use,
    -- so `:ClaudeCode` and friends work on a fresh start. Without it, a keys-only
    -- spec defers loading until a <leader>a* mapping is pressed and the commands
    -- would not exist yet.
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSelectModel",
      "ClaudeCodeAdd",
      "ClaudeCodeSend",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeStatus",
      "ClaudeCodeStart",
      "ClaudeCodeStop",
      "ClaudeCodeOpen",
      "ClaudeCodeClose",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
      "ClaudeCodeCloseAllDiffs",
    },
    keys = {
      { "<leader>a",  "<cmd>ClaudeCodeOpen<cr>",                    desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",                        desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",                   desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",               desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>",             desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>",             desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",                   desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
