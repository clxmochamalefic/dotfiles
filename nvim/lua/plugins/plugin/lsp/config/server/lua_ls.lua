-- ---------------------------------------------------------------------------
-- lua_ls - deno/typescript LSP SERVER CONFIG
-- ---------------------------------------------------------------------------

local M = {}

M.setup = function(baseLc, lc, opts)
  opts = opts or {}

  opts.root_dir = baseLc.util.root_pattern(".luacheckrc", ".rockspec")
  opts.filetypes = { "lua" }
  opts.single_file_support = true

  lc.setup(opts)
end

return M
