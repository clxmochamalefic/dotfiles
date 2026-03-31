-- ---------------------------------------------------------------------------
-- UI FILER PLUGINS
-- ---------------------------------------------------------------------------

local M = {}

--local nvim_tree = require("plugins.rc.ui.filer.nvim-tree")
local neo_tree = require("plugins.rc.ui.filer.neo-tree")
local vim_yazi = require("plugins.rc.ui.filer.vim_yazi")

-- 使うファイラプラグインを選択、または追加する
table.insert(M, neo_tree)
table.insert(M, vim_yazi)

return M

