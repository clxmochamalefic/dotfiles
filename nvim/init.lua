-- debug mode
vim.g.is_enable_my_debug = false

local utils = require("utils")

-- this init.vim is using utf-8
vim.opt.encoding = "utf-8"
vim.scriptencoding = "utf-8"

vim.opt.helplang = { "ja", "en" }

-- disable `vi` compatible
vim.o.compatible = false

-- reset augroup
vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })

-- get preference file path
-- `vim.g.preference_path` defined on ~/.cache/nvim/init.vim
vim.g.my_home_preference_path = vim.fn.expand("~/.config/nvim")
vim.g.my_home_cache_path = vim.fn.expand("~/.cache")
local my_home_path = vim.fn.expand("~")
vim.g.my_home_path = my_home_path
vim.g.my_initvim_path = vim.fn.expand(vim.g.preference_path)

utils.io.debug_echo("load rc")

local base = require("preferences.base")
local path = require("preferences.path")
local ft = require("preferences.ft")
local mapping = require("preferences.mapping")
local command = require("preferences.command")
local colour = require("preferences.colour")
local window = require("preferences.window")
local gui = { setup = function() end }
if vim.g.neovide then
  gui = require("preferences.gui")
end

local plugins = require("plugins")

utils.io.begin_debug(vim.g.my_initvim_path)

utils.io.debug_echo("load plugins")

path.setup()

base.setup()

plugins.setup()

ft.setup()
mapping.setup()
command.setup()

colour.setup()
window.setup()

gui.setup()


-- selfmade plugins development
--vim.opt.runtimepath:append(my_home_path .. "/repos/denops/soil.denops")
--vim.opt.runtimepath:append("/home/nao/repos/denops/soil.denops")
--vim.g["denops#debug"] = 1

-- debug plugin

utils.io.end_debug(vim.g.my_initvim_path)
