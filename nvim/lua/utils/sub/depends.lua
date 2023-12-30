local fn = vim.fn

local M = {}

local pms = {
  'apt',
  'yum',
  'brew',
  'apk',
  'winget',
}

local function get_pm_command(name)
---@diagnostic disable-next-line: unused-local
  for i,v in ipairs(pms) do
    if fn.executable(v) then
      return "!" .. v .. " install -y " .. name
    end
  end
  error('have not defined package manager name in list, plz update me: utils.sub.depends.lua')
end

function M.has_depends(name)
  return fn.executable(name) > 0
end

function M.install_depends(name)
  if fn.executable(name) < 1 then
    local installCommand = get_pm_command(name)
    vim.cmd(installCommand)
  end
end

return M
