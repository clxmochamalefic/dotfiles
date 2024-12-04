local utils = require("utils")

local global = require("plugins.plugin.ddc.config.global")
local noice = require("plugins.plugin.ddc.config.noice")

local keymap = require("plugins.plugin.ddc.config.keymap")

local M = {
  global = global,
  noice = noice,

  keymap = keymap,
  events = global.autocomplete_events,
}

M.ddc_init = function()
  utils.io.begin_debug("ddc_init")

  vim.fn["ddc#custom#patch_global"](M.global.get_config())
  vim.fn["ddc#custom#patch_filetype"]({ 'noice' }, M.noice.get_config())

  --  use ddc.
  vim.fn["ddc#enable"]()
  vim.fn["ddc#enable_cmdline_completion"]()
  vim.fn["ddc#enable_terminal_completion"]()

  utils.io.end_debug("ddc_init")
end


return M
