require('utils')
-- this init.vim is using utf-8
vim.o.enconfig = 'utf-8'
vim.scriptencoding = 'utf-8'

vim.o.helplang = {'ja', 'en'}

-- disable `vi` compatible
vim.o.compatible = false

-- reset augroup
vim.api.nvim_create_augroup('MyAutoCmd', { clear = true })

-- debug mode
vim.g.is_enable_my_debug = false

-- get preference file path
-- `vim.g.preference_path` defined on ~/.cache/nvim/init.vim
vim.g.my_home_preference_path = vim.fn.expand("~/.config/nvim")
vim.g.my_initvim_path = vim.fn.expand(vim.g.preference_path)



DebugEcho('begin ' + vim.g.my_initvim_path + ' load')

local python_preference_path = vim.g.my_home_preference_path

-- python path
if !FileExists(python_preference_path + '/python.lua') then
  local py2pref = ""
  local py3pref = ""

  if vim.fn.has('win32') then
    local path = vim.fn.command("gcm python | select-Object Source")
    local py3pref = "vim.g.python3_host_prog = " + path

  elseif vim.fn.has('mac') then
    -- TODO: PLZ TEST ME!!
    local py2pref = "vim.g.python2_host_prog = " + "$PYENV_ROOT.'/versions/neovim2/bin/python'"
    local py3pref = "vim.g.python3_host_prog = " + "$PYENV_ROOT.'/versions/neovim3/bin/python'"

  end

  local body = py2pref + "\n" + py3pref + "\n"
  io.open(python_preference_path + '/python.lua', "w"):write(body):close()
end


DebugEcho('load rc')

vim.fn.runtime("/lua/preferences/base.lua")

vim.fn.runtime("/lua/plugins")

vim.fn.runtime("/lua/preferences/ft.lua")
vim.fn.runtime("/lua/preferences/mapping.lua")
vim.fn.runtime("/lua/preferences/color.lua")
vim.fn.runtime("/lua/preferences/command.lua")

DebugEcho('end' + vim.g.my_initvim_path + ' load')

