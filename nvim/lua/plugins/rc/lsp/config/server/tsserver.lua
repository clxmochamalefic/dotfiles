-- ---------------------------------------------------------------------------
-- tsserver - typescript LSP SERVER CONFIG
-- ---------------------------------------------------------------------------

local M = {}

M.setup = function(baseLc, lc, opts)
  opts = opts or {}
  local is_node = baseLc.util.find_node_modules_ancestor
  opts.root_dir = baseLc.util.root_pattern("tsconfig.json")
  --if is_node and (not enabled_vtsls) then
  --  lspconfig["tsserver"].setup({})
  --end
  lc.setup(opts)
  --if is_node then
  --  lc.setup(opts)
  --end
end

return M
