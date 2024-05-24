-- ---------------------------------------------------------------------------
-- UI NOTIFY PLUGINS
-- ---------------------------------------------------------------------------

local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local nc = require("plugins.plugin.ui.config.nui.noice-nvim")

return {
  {
    --lazy = true,
    --event = { "VeryLazy" },
    cond = true,
    "rcarriga/nvim-notify",
    tag = "v3.13.5",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      vim.notify = require("notify")
      vim.notify.setup({
        render = "wrapped-compact",
        max_width = 60,
        background_colour = "#000000",
        fps = 10,
      })

      local telescope = require("telescope")
      telescope.load_extension("notify")

      keymap.set("n", "<leader>n", telescope.extensions.notify.notify)
    end,
  },
  {
    --lazy = true,
    --event = { "VeryLazy" },
    cond = true,
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope.nvim",
    },
    opts = function(_, opts)
      -- add any options here
      opts.routes = nc.routes
      opts.notify = nc.notify
      opts.cmdline = nc.cmdline
      opts.health = nc.health
      opts.lsp = nc.lsp
      opts.messages = nc.messages
      opts.redirect = {
        view = "notify",
        filter = { event = "msg_show" },
      }
      opts.popupmenu = nc.popupmenu
      opts.presets = nc.presets
    end,
    config = function(_, opts)
      require("noice").setup(opts)
      require("telescope").load_extension("notify")
    end,
  },
}
