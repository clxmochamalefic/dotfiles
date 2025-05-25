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
}
