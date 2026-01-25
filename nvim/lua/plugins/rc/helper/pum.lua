---@diagnostic disable: undefined-global
local config = require('plugins.rc.config.pum')
local blend = require('utils.colour')

local M = {}

M.setup = function()
  vim.fn['pum#set_option'](config)
  --vim.notify("blend: " .. vim.g.blend)
  vim.api.nvim_set_option('pumblend', blend.get_pumblend())
  -- DEPRECATED: これをONにすると `nvim-notify` の背景透過が消える
  --vim.api.nvim_set_option('winblend', blend.get_pumblend())
end

return M
