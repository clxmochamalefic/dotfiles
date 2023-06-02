local utils = require('utils')

-- this init.vim is using utf-8
vim.opt.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'

vim.opt.helplang = {'ja', 'en'}

-- disable `vi` compatible
vim.o.compatible = false

-- reset augroup
vim.api.nvim_create_augroup('MyAutoCmd', { clear = true })

-- ------------------------------------------------------------
-- debug mode
-- ------------------------------------------------------------
vim.g.is_enable_my_debug = false

-- get preference file path
-- `vim.g.preference_path` defined on ~/.cache/nvim/init.vim
vim.g.my_home_preference_path = vim.fn.expand("~/.config/nvim")
vim.g.my_initvim_path = vim.fn.expand(vim.g.preference_path)

utils.debug_echo('load rc')

local base    = require("preferences.base")
local ft      = require("preferences.ft")
local mapping = require("preferences.mapping")
local command = require("preferences.command")
local colour  = require("preferences.colour")

local plugins = require("plugins")

utils.begin_debug(vim.g.my_initvim_path)

local python_preference_path = vim.g.my_home_preference_path

-- python path
if not utils.file_exists(python_preference_path .. '/python.lua') then
  local py2pref = ""
  local py3pref = ""

  if vim.fn.has('win32') then
    local path = vim.cmd("!gcm python | select-Object Source")
    local py3pref = "vim.g.python3_host_prog = " .. path

  elseif vim.fn.has('mac') then
    -- TODO: PLZ TEST ME!!
    local py2pref = "vim.g.python2_host_prog = " .. "$PYENV_ROOT.'/versions/neovim2/bin/python'"
    local py3pref = "vim.g.python3_host_prog = " .. "$PYENV_ROOT.'/versions/neovim3/bin/python'"

  end

  local body = py2pref .. "\n" .. py3pref .. "\n"

  utils.debug_echo('python preference path' .. python_preference_path)
  utils.debug_echo('python preference body' .. body)

  io.open(python_preference_path .. '/python.lua', "w"):write(body):close()
end

utils.debug_echo('load plugins')

base.setup()

plugins.setup()

ft.setup()
mapping.setup()
command.setup()

colour.setup()

utils.end_debug(vim.g.my_initvim_path)

