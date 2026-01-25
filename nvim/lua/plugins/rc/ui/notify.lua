-- ---------------------------------------------------------------------------
-- UI NOTIFY PLUGINS
-- ---------------------------------------------------------------------------

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
    tag = "v3.15.0",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      render = "wrapped-compact",
      max_width = 80,
      background_colour = "#000000",
      opacity = 90,
      fps = 10,
    },
    config = function(_, opts)
      vim.notify = require("notify")
      vim.notify.setup(opts)

      --local t = require("telescope")
      --telescope = t
    end,
  },
}
