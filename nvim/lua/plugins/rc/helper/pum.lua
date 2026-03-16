---@diagnostic disable: undefined-global
local pumconfig = require('plugins.rc.config.pum')
local colour = require('const.colour')

local M = {}

M.setup = function()
  vim.fn['pum#set_option'](pumconfig)
  --vim.notify("blend: " .. vim.g.blend)
  vim.api.nvim_set_option('pumblend', colour.get_pumblend())
  -- DEPRECATED: これをONにすると `nvim-notify` の背景透過が消える
  --vim.api.nvim_set_option('winblend', colour.get_pumblend())
end

return M
