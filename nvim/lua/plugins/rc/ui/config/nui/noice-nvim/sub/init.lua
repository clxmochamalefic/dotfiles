-- ---------------------------------------------------------------------------
-- SUB CONFIGS FOR NOICE-NVIM
-- ---------------------------------------------------------------------------

return {
  notify = require("plugins.rc.ui.config.nui.noice-nvim.sub.notify"),
  routes = require("plugins.rc.ui.config.nui.noice-nvim.sub.notify-routes"),
  cmdline = require("plugins.rc.ui.config.nui.noice-nvim.sub.cmdline"),
  lsp = require("plugins.rc.ui.config.nui.noice-nvim.sub.lsp"),
  health = require("plugins.rc.ui.config.nui.noice-nvim.sub.health"),
  messages = require("plugins.rc.ui.config.nui.noice-nvim.sub.messages"),
  popupmenu = require("plugins.rc.ui.config.nui.noice-nvim.sub.popupmenu"),
  presets = require("plugins.rc.ui.config.nui.noice-nvim.sub.presets"),
}
