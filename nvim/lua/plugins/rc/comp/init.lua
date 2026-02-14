---@diagnostic disable: undefined-global
-- ---------------------------------------------------------------------------
-- COMPletion PLUGINS
-- ---------------------------------------------------------------------------

local M = {}

local ddc = require("plugins.rc.comp.ddc")
table.insert(M, ddc)

return M;
