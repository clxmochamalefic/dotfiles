local M = {}

local function clipFileName()
  local v = vim.fn.expand('%')
  vim.cmd([[let @+ = expand('%')]])
  vim.notify('Copied file name: ' .. v, vim.log.levels.INFO)
end

local function clipFilePath()
  local v = vim.fn.expand('%:p')
  vim.cmd([[let @+ = expand('%:p')]])
  vim.notify('Copied file path: ' .. v, vim.log.levels.INFO)
end

M.setup = function()
  vim.api.nvim_create_user_command("ClipFileName", clipFileName, {})
  vim.api.nvim_create_user_command("ClipFilePath", clipFilePath, {})
end

return M
