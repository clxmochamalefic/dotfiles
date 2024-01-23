-- ---------------------------------------------------------------------------
-- jdtls - java LSP SERVER CONFIG
-- ---------------------------------------------------------------------------

local M = {}

M.setup = function(baseLc, lc, opts)
  lc.setup({
    root_dir = baseLc.util.root_pattern("build.gradle", "pom.xml", ".git"),
  })
end

return M
