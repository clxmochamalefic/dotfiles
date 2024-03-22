-- ---------------------------------------------------------------------------
-- TEELSCOPE PLUGINS
-- ---------------------------------------------------------------------------

local M = {}

local tls = require("plugins.plugin.fzf.telescope")

local ext_fzf = require("plugins.plugin.fzf.ext.fzf-native")
local ext_lga = require("plugins.plugin.fzf.ext.live-grep-args")
local ext_mem = require("plugins.plugin.fzf.ext.memo")

local oth = require("plugins.plugin.fzf.other-nvim")

table.insert(M, tls)

table.insert(M, ext_fzf)
table.insert(M, ext_lga)
table.insert(M, ext_mem)

table.insert(M, oth)

return M
