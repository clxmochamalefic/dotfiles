-- ---------------------------------------------------------------------------
-- UI FILER PLUGINS
-- ---------------------------------------------------------------------------

local M = {}

--local nvim_tree = require("plugins.plugin.ui.filer.nvim-tree")
local neo_tree = require("plugins.plugin.ui.filer.neo-tree")

-- 使うファイラプラグインを選択、または追加する
table.insert(M, neo_tree)

return M

