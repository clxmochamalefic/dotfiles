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

utils.io.debug_echo('load rc')

local base    = require("preferences.base")
local path    = require("preferences.path")
local ft      = require("preferences.ft")
local mapping = require("preferences.mapping")
local command = require("preferences.command")
local colour  = require("preferences.colour")
local wnd     = require("preferences.window")

local plugins = require("plugins")

utils.io.begin_debug(vim.g.my_initvim_path)

utils.io.debug_echo('load plugins')

path.setup()

base.setup()

plugins.setup()

ft.setup()
mapping.setup()
command.setup()

colour.setup()
wnd.setup()

utils.io.end_debug(vim.g.my_initvim_path)

