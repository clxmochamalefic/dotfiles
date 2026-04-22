-- ---------------------------------------------------------------------------
-- UI NOTIFY PLUGINS
-- ---------------------------------------------------------------------------

return {
  {
    lazy = true,
    event = { "VeryLazy" },
    cond = true,
    "rcarriga/nvim-notify",
    tag = "v3.15.0",
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
    end,
  },
}
