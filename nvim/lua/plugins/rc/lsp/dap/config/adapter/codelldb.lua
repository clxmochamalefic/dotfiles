-- ---------------------------------------------------------------------------
-- DAP - cpptools (C++) CONFIGS
-- ---------------------------------------------------------------------------
require('plugins.rc.lsp.dap.config.adapter._types')
--- @var DAPのアダプタ用のユーティリティ
local adaptutil = require('plugins.rc.lsp.dap.config.adapter._utils')
--- 自前実装のneovimのユーティリティのうち、OS環境のもの
local envutil = require("utils.env");

local debugInfo = debug.getinfo(1)
local filename = debugInfo.source:match("[^/]*$")
local fn_without_ext = filename:sub(1, #filename - 4) -- 拡張子を取る

vim.print("filename: " .. fn_without_ext)

local dap_name = fn_without_ext
local default_port = 13000
local executable_path = adaptutil.get_executable_path(dap_name, 'adapter')

local config = {
  -- 複数指定することもできる
  -- 複数あるとデバッグ開始時にどの設定使うか聞かれる
  {
    -- なくてもいい。複数の設定があるとき、それらを識別するための名前
    name = 'Launch file',

    -- dap.adapters にあるデバッガから、どれを使うか
    type = dap_name,

    -- デバッガ起動する
    request = 'launch',

    -- コンパイル時に -g オプションをつけてビルドした実行ファイルを指定する
    -- こんな感じでinputで指定できるようにしておく
    program = function()
      local path = envutil.join_path(vim.fn.getcwd(), 'a.out')
      return vim.fn.input('Path to executable: ', path, 'file')
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
  executable_path = executable_path,
  name = dap_name,

  ft = ft_list,
  adapter_config = {
    type = 'server',
    port = '${port}',
    executable = {

      -- Masonはここにデバッガを入れてくれる
      command = executable_path,

      -- ポートを自動的に割り振ってくれる
      args = {'--port', '${port}'}
    }
  },
  ft_config = adaptutil.make_ft_config_table(ft_list, config),
}

return M

