-- ---------------------------------------------------------------------------
-- UI NOTIFY PLUGINS
-- ---------------------------------------------------------------------------

local nc = require("plugins.rc.ui.config.nui.noice-nvim")

local hasAlreadyLoaded = false
local telescope = nil

local function open_telescope_notify()
  if (telescope == nil) then
    return
  end
  if not hasAlreadyLoaded then
    hasAlreadyLoaded = true
    telescope.load_extension("notify")
  end

  telescope.extensions.notify.notify()
end

return {
  {
    lazy = true,
    event = { "VeryLazy" },
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

      local t = require("telescope")
      telescope = t
    end,
  },
  {
    lazy = true,
    "folke/noice.nvim",
    cond = true,
    event = { "VeryLazy" },
    keys = {
      {
        "<leader>n",
        open_telescope_notify,
        {
          mode = "n",
          desc = "Open Telescope Notify"
        }
      },
    },
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
      opts.progress = nc.progress
      opts.popupmenu = nc.popupmenu
      opts.presets = nc.presets
    end,
    config = function(_, opts)
      require("noice").setup(opts)
    end,
  },
}
