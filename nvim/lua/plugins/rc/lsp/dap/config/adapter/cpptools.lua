-- ---------------------------------------------------------------------------
-- DAP - cpptools (C++) CONFIGS
-- ---------------------------------------------------------------------------
require('plugins.rc.lsp.dap.config.adapter._type')
local util = require('plugins.rc.lsp.dap.config.adapter._util')

local dap_name = 'cpptools'
local default_port = 13000
local executable_path = util.get_executable_path(dap_name)

local config = {
  -- 複数指定することもできる
  -- 複数あるとデバッグ開始時にどの設定使うか聞かれる
  {
    -- なくてもいい。複数の設定があるとき、それらを識別するための名前
    name = 'Launch file',

    -- dap.adapters にあるデバッガから、どれを使うか
    type = 'cpptools',

    -- デバッガ起動する
    request = 'launch',

    -- コンパイル時に -g オプションをつけてビルドした実行ファイルを指定する
    -- こんな感じでinputで指定できるようにしておく
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/a.out', 'file')
    end,

    -- よく分からないけど、nvim-dapのWikiに書いてあったので
    cwd = '${workspaceFolder}',

    -- trueだとバイナリのデバッグになっちゃう(なんで?)
    stopOnEntry = false
  }
}

local ft_list = {
  "c",
  "cc",
  "cpp",
  "h",
  "hpp",
}

--- @type my_adapter_config
local M = {
  ft = ft_list,
  adapter_config = {
    type = 'server',
    port = default_port,
    executable = {

      -- Masonはここにデバッガを入れてくれる
      command = executable_path,

      -- ポートを自動的に割り振ってくれる
      args = {'--port', '${port}'}
    }
  },
  ft_config = util.make_ft_config_table(ft_list, config),
}

return M

