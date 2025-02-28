-- ---------------------------------------------------------------------------
-- UI PLUGINS
-- ---------------------------------------------------------------------------

local M = {}

local editor = require("plugins.rc.ui.editor")
local viewer = require("plugins.rc.ui.viewer")
local filer = require("plugins.rc.ui.filer")
local fzf = require("plugins.rc.ui.fzf")
local notify = require("plugins.rc.ui.notify")
local nui = require("plugins.rc.ui.nui")
local statusline = require("plugins.rc.ui.statusline")
local window = require("plugins.rc.ui.window")

table.insert(M, editor)
table.insert(M, viewer)
table.insert(M, filer)
table.insert(M, fzf)
table.insert(M, notify)
table.insert(M, nui)
table.insert(M, statusline)
table.insert(M, window)

return M
