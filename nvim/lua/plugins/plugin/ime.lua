--local g = vim.g
--local fn = vim.fn
--local uv = vim.uv
--local api = vim.api
--local opt = vim.opt
--local keymap = vim.keymap
--
--local myWinPick = require("plugins.plugin.config.winpick")
--local utils = require("utils")
--
--local myDenops = require("plugins.plugin.config.denops")
--

local skk = require("plugins.plugin.config.ime.skk")

return {
  --  {
  --    'keaising/im-select.nvim',
  --    config = function()
  --      require('im_select').setup {
  --      }
  --    end
  --  }
  {
    lazy = true,
    "vim-skk/skkeleton",
    dependencies = {
      "vim-denops/denops.vim",
      "delphinus/skkeleton_indicator.nvim",
      "ddc.vim",
    },
    event = { "InsertEnter", "CursorHold" },
    config = function()
      -- skk how to use
      -- winget install 
      -- download below, extract, and create symblink to shell:startup
      -- https://github.com/nathancorvussolis/crvskkserv/releases/tag/2.5.6
      skk.setup()
    end,
  },
  {
    "delphinus/skkeleton_indicator.nvim",
    config = function()
      require("skkeleton_indicator").setup()
    end,
  },
}
