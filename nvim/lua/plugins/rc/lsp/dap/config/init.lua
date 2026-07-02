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
local phpdap = require(adapter_dir .. 'php_debug_adapter')

local adapter_list = {}
local ft_config_list = {}

---
--- 実行ファイルが存在するアダプタだけ登録し、filetypeごとの設定もマージする
---
--- @param adapter my_adapter_config
---
local function register(adapter)
  local inserted = _table.insert_when(
    adapter_list,
    adapter.name,
    adapter.adapter_config,
    _fs.exists(adapter.executable_path)
  )
  if inserted then
    for ft, config in pairs(adapter.ft_config) do
      ft_config_list[ft] = config
    end
  end
end

register(codelldb)
register(phpdap)

local M = {
  adapter_list = adapter_list,
  ft_config_list = ft_config_list,
  lang = vim.tbl_keys(ft_config_list),
}

return M
