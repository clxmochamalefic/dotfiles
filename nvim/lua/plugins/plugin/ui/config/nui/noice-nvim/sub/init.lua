-- ---------------------------------------------------------------------------
-- SUB CONFIGS FOR NOICE-NVIM
-- ---------------------------------------------------------------------------

return {
  notify = require("plugins.plugin.ui.config.nui.noice-nvim.sub.notify"),
  routes = require("plugins.plugin.ui.config.nui.noice-nvim.sub.notify-routes"),
  cmdline = require("plugins.plugin.ui.config.nui.noice-nvim.sub.cmdline"),
  lsp = require("plugins.plugin.ui.config.nui.noice-nvim.sub.lsp"),
  health = require("plugins.plugin.ui.config.nui.noice-nvim.sub.health"),
  messages = require("plugins.plugin.ui.config.nui.noice-nvim.sub.messages"),
  popupmenu = require("plugins.plugin.ui.config.nui.noice-nvim.sub.popupmenu"),
  presets = require("plugins.plugin.ui.config.nui.noice-nvim.sub.presets"),
}
