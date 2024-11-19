-- ---------------------------------------------------------------------------
-- TEELSCOPE PLUGINS
-- ---------------------------------------------------------------------------

local tls = require("plugins.plugin.ui.fzf.telescope")
--local oth = require("plugins.plugin.ui.fzf.other")
local ext = require("plugins.plugin.ui.fzf.ext")

local M = {}

table.insert(M, tls)
--table.insert(M, oth)

for _, v in ipairs(ext) do
  table.insert(M, v)
end

return M
