---@diagnostic disable: undefined-global
local config = require('plugins.plugin.config.pum')

local M = {}

M.setup = function()
  vim.fn['pum#set_option'](config)
  local blend = vim.g.blend
  vim.api.nvim_set_option('pumblend', blend)
  vim.api.nvim_set_option('winblend', blend)
end

return M
