-- ---------------------------------------------------------------------------
-- UI PLUGINS
-- ---------------------------------------------------------------------------

local M = {}

local editor = require("plugins.plugin.ui.editor")
local notify = require("plugins.plugin.ui.notify")
local nui = require("plugins.plugin.ui.nui")
local nvimtree = require("plugins.plugin.ui.nvim-tree")
local statusline = require("plugins.plugin.ui.statusline")
local window = require("plugins.plugin.ui.window")

table.insert(M, editor)
table.insert(M, notify)
table.insert(M, nui)
table.insert(M, nvimtree)
table.insert(M, statusline)
table.insert(M, window)

return M
