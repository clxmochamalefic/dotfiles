local global = require("plugins.plugin.ddc.config.global")
local noice = require("plugins.plugin.ddc.config.noice")

local M = {
  global = global,
  noice = noice,

  events = global.autocomplete_events,
}

return M
