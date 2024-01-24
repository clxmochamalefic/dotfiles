-- ---------------------------------------------------------------------------
-- UI NOTIFY PLUGINS
-- ---------------------------------------------------------------------------

local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local noice_config = require("plugins.plugin.config.nui.noice-nvim")

return {
  {
    lazy = true,
    "rcarriga/nvim-notify",
    event = { "VeryLazy" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    init = function()
      vim.notify = require("notify")
      vim.notify.setup({
        max_width = 120,
        background_colour = "#000000",
        fps = 10,
      })
    end,
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("notify")

      keymap.set("n", "<leader>n", telescope.extensions.notify.notify)
    end,
  },
  {
    lazy = true,
    "folke/noice.nvim",
    event = { "VeryLazy" },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = function(_, opts)
      -- add any options here
      opts.routes = noice_config.routes
      opts.lsp = {
        override = {},
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
      }
      opts.presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      }
    end,
    config = function(_, opts)
      require("noice").setup(opts)
    end,
  },
}
