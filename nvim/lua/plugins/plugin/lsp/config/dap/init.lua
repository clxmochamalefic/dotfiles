-- ---------------------------------------------------------------------------
-- DAP (debug adapter protocol) CONFIGS
-- ---------------------------------------------------------------------------

local cs = require('plugins.plugin.lsp.config.dap.lang.csharp')

local M = {
  dap = nil,
  lang = {
    java = require('plugins.plugin.lsp.config.dap.lang.java'),
    cs = cs,
    csharp = cs,
  }
}

M.setup = function(dap)
  M.dap = dap
end

M.start = function(opt)
  M.lang[opt.lang].setup(M.dap, opt)
end

return M
