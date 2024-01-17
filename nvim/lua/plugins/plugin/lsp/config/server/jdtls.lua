-- ---------------------------------------------------------------------------
-- jdtls - java LSP SERVER CONFIG
-- ---------------------------------------------------------------------------

local M = {}

M.setup = function(baseLc, lc, opts)
  --if is_node and (not enabled_vtsls) then
  --  lspconfig["tsserver"].setup({})
  --end
  lc.setup({
    root_dir = baseLc.util.root_pattern("build.gradle", "pom.xml", ".git"),
  })
end

return M
