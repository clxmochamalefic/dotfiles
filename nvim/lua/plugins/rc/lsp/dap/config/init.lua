-- ---------------------------------------------------------------------------
-- DAP (debug adapter protocol) CONFIGS
-- ---------------------------------------------------------------------------

require('plugins.rc.lsp.dap.config.adapter._type')

local lang_dir = 'plugins.rc.lsp.dap.config.adapter.'

--local cs = require(lang_dir .. 'csharp')
--local java = require(lang_dir .. 'java')
--local cpptools = require(lang_dir .. 'cpptools')
local codelldb = require(lang_dir .. 'codelldb')

local M = {
  adapter_list = {
    --java = java,
    --cs = cs,
    --cpptools = cpptools.adapter_config,
    codelldb = codelldb.adapter_config,
  },
  -- TODO: 他のDAPとマージしないとならない
  ft_config_list = codelldb.ft_config,

}

M.setup = function(dap)
  M.dap = dap
end

M.start = function(opt)
  M.lang[opt.lang].setup(M.dap, opt)
end

return M
