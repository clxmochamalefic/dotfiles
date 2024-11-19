local M = {}

local ext_emj = require("plugins.plugin.ui.fzf.ext.emoji")

local ext_mru = require("plugins.plugin.ui.fzf.ext.mru")
local ext_ntv = require("plugins.plugin.ui.fzf.ext.fzf-native")

local ext_lga = require("plugins.plugin.ui.fzf.ext.live-grep-args")
local ext_mem = require("plugins.plugin.ui.fzf.ext.memo")

table.insert(M, ext_emj)
table.insert(M, ext_mru)
table.insert(M, ext_ntv)
table.insert(M, ext_lga)
table.insert(M, ext_mem)

return M
