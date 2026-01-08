local M = {}

local function showMap()
  vim.cmd([[new | put =execute('map')]])
end

local function showNMap()
  vim.cmd([[new | put =execute('nmap')]])
end
local function showIMap()
  vim.cmd([[new | put =execute('imap')]])
end
local function showTMap()
  vim.cmd([[new | put =execute('tmap')]])
end

M.setup = function()
  vim.api.nvim_create_user_command("ShowMap", showMap, {})
  vim.api.nvim_create_user_command("ShowNMap", showNMap, {})
  vim.api.nvim_create_user_command("ShowIMap", showIMap, {})
  vim.api.nvim_create_user_command("ShowTMap", showTMap, {})
end

M.keymap = function()
end

return M
