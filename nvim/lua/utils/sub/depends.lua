local fn = vim.fn

local myutils = require("utils.sub.util")

local M = {}

local pms = {
  'apt',
  'yum',
  'brew',
  'apk',
  'winget',
}

local pms_prefix = {
  apt = 'sudo',
  yum = 'sudo',
  brew = '',
  apk = '',
  winget = '',
}

local pms_args = {
  apt = 'install -y',
  yum = 'install -y',
  brew = '',
  apk = 'add',
  winget = 'install',
}

local pms_suffix = {
  apt = '',
  yum = '',
  brew = '',
  apk = '',
  winget = '--silent',
}

local function get_pm_command_with_pm_name(name, pm_name)
  return "!" .. pms_prefix[pm_name] .. " " .. pm_name .. " " .. pms_args[pm_name] .. " " .. name .. " " .. pms_suffix[pm_name]
end

local function get_pm_command(name)
---@diagnostic disable-next-line: unused-local
  for i,v in ipairs(pms) do
    if fn.executable(v) > 0 then
      get_pm_command_with_pm_name(name, v)
    end
  end
  error('have not defined package manager name in list, plz update me: utils.sub.depends.lua')
end

function M.has(name)
  return fn.executable(name) > 0
end

function M.which(name)
  return fn.exepath(name)
end

function M.install(name, verb)
  myutils.try_catch({
    try = function()
      if fn.executable(name) < 1 then
        local installCommand = ''
        if verb then
          for k,v in pairs(pms) do
            if fn.executable(v) > 0 then
              get_pm_command_with_pm_name(v, k)
              break
            end
          end
        else
          ---@diagnostic disable-next-line: cast-local-type
          installCommand = get_pm_command(name)
        end
        vim.cmd(installCommand)
      end
    end,
    catch = function()
    end
  })
end

return M
