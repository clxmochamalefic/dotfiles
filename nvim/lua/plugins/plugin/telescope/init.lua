-- ---------------------------------------------------------------------------
-- TEELSCOPE PLUGINS
-- ---------------------------------------------------------------------------

local M = {}

local tls = require("plugins.plugin.telescope.telescope")

local ext_fzf = require("plugins.plugin.telescope.ext.fzf-native")
local ext_lga = require("plugins.plugin.telescope.ext.live-grep-args")
local ext_mem = require("plugins.plugin.telescope.ext.memo")

table.insert(M, tls)

table.insert(M, ext_fzf)
table.insert(M, ext_lga)
table.insert(M, ext_mem)

return M
