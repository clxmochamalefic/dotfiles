-- ---------------------------------------------------------------------------
-- DAP (debug adapter protocol) CONFIGS
-- ---------------------------------------------------------------------------
require('plugins.rc.lsp.dap.config.adapter._types')

local _fs = require('utils.fs')
local _table = require('utils.table')

local adapter_dir = 'plugins.rc.lsp.dap.config.adapter.'

--local cs = require(lang_dir .. 'csharp')
--local java = require(lang_dir .. 'java')
--local cpptools = require(lang_dir .. 'cpptools')
local codelldb = require(adapter_dir .. 'codelldb')

local adapter_list = {}

_table.insert_when(adapter_list, codelldb.name, codelldb.adapter_config, _fs.exists(codelldb.executable_path))

local M = {
  adapter_list = adapter_list,
  -- TODO: 他のDAPとマージしないとならない
  ft_config_list = codelldb.ft_config,

}

return M
