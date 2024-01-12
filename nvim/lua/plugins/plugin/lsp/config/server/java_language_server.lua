-- ---------------------------------------------------------------------------
-- java_language_server - java LSP SERVER CONFIG
-- ---------------------------------------------------------------------------

local M = {}

M.setup = function(baseLc, lc, opts)
  local is_node = baseLc.util.find_node_modules_ancestor
  --if is_node and (not enabled_vtsls) then
  --  lspconfig["tsserver"].setup({})
  --end
  if is_node then
    lc.setup({
      root_dir = baseLc.util.root_pattern("build.gradle", "pom.xml", ".git"),
    })
  end
end

return M

