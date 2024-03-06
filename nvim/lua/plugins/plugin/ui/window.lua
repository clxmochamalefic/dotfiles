-- ---------------------------------------------------------------------------
--  UI WINDOW PLUGINS
-- ---------------------------------------------------------------------------

local winpickConfig = require("plugins.plugin.ui.config.winpick")

return {
  {
    "gbrlsnchs/winpick.nvim",
    cmd = { "WinPick" },
    keys = {
      { "-", "<cmd>WinPick<CR>", mode = "n" },
    },
    config = function()
      winpickConfig.setup()
    end,
  },
}
