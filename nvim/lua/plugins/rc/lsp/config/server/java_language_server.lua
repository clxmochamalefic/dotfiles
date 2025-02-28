-- ---------------------------------------------------------------------------
-- java_language_server - java LSP SERVER CONFIG
-- ---------------------------------------------------------------------------

local M = {}

M.setup = function(baseLc, lc, opts)
  opts = opts or {}
  opts.root_dir = baseLc.util.root_pattern("build.gradle", "pom.xml", ".git")
  lc.setup(opts)
end

return M
