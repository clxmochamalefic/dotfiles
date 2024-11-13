-- ---------------------------------------------------------------------------
-- DAP (debug adapter protocol) CONFIGS
-- ---------------------------------------------------------------------------

local lang_dir = 'plugins.plugin.lsp.dap.config.lang.'

local cs = require(lang_dir .. 'csharp')
local java = require(lang_dir .. 'java')

local M = {
  dap = nil,
  lang = {
    java = java,
    cs = cs,
    csharp = cs,
  },
}

M.setup = function(dap)
  M.dap = dap
end

M.start = function(opt)
  M.lang[opt.lang].setup(M.dap, opt)
end

return M
