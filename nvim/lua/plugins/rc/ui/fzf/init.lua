-- ---------------------------------------------------------------------------
-- TEELSCOPE PLUGINS
-- ---------------------------------------------------------------------------

local tls = require("plugins.rc.ui.fzf.telescope")
--local oth = require("plugins.rc.ui.fzf.other")
local ext = require("plugins.rc.ui.fzf.ext")

local M = {}

table.insert(M, tls)
--table.insert(M, oth)

for _, v in ipairs(ext) do
  table.insert(M, v)
end

return M
