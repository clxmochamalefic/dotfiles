-- ---------------------------------------------------------------------------
-- UI NOTIFY PLUGINS
-- ---------------------------------------------------------------------------

local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local noice_config = require("plugins.plugin.ui.config.nui.noice-nvim")

return {
  {
    lazy = true,
    "rcarriga/nvim-notify",
    event = { "VeryLazy" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      vim.notify = require("notify")
      vim.notify.setup({
        render = "compact",
        max_width = 120,
        background_colour = "#000000",
        fps = 10,
      })

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
      "nvim-telescope/telescope.nvim",
    },
    opts = function(_, opts)
      -- add any options here
      opts.routes = noice_config.routes
      opts.notify = {
        enabled = true,
        view = "notify",
      }
      opts.lsp = {
        override = {
          ---- override the default lsp markdown formatter with Noice
          --["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          ---- override the lsp markdown formatter with Noice
          --["vim.lsp.util.stylize_markdown"] = false,
          ---- override cmp documentation with Noice (needs the other options to work)
          --["cmp.entry.get_documentation"] = false,
        },
        hover = {
          enabled = false,
          --view = "mini",
        },
        signature = {
          enabled = false,
          --view = "mini",
        },
        message = {
          enabled = false,
          view = "notify",
          opts = {},
        },
        documentation = {
          enabled = false,
          --view = "mini",
        },
        progress = {
          enabled = true,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          throttle = 1000 / 30,
          --view = "mini",
        },
      }
      opts.messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = true, -- enables the Noice messages UI
        view = "notify", -- default view for messages
        view_error = "notify", -- view for errors
        view_warn = "notify", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = false, -- view for search count messages. Set to `false` to disable
      }
      opts.redirect = {
        view = "popup",
        filter = { event = "msg_show" },
      }
      opts.presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      }
    end,
    config = function(_, opts)
      require("noice").setup(opts)
      --require("telescope").load_extension("notify")
    end,
  },
}
