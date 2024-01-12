-- ---------------------------------------------------------------------------
-- DAP (debug adapter protocol) CONFIGS
-- ---------------------------------------------------------------------------

local M = {
  dap = nil,
  lang = {
    java = require('plugins.plugin.lsp.config.dap.lang.java'),
  }
}

M.setup = function(dap)
  M.dap = dap
end

M.start = function(opt)
  M.lang[opt.lang].setup(M.dap, opt)
end

return M
