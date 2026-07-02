-- ---------------------------------------------------------------------------
-- DAP - php debug adapter (php CONFIGS
-- ---------------------------------------------------------------------------
require('plugins.rc.lsp.dap.config.adapter._types')
local util = require('plugins.rc.lsp.dap.config.adapter._utils')
local envutil = require('utils.env')

-- Masonのパッケージ名 (実体はvscode-php-debug)
local mason_package = 'php-debug-adapter'

-- dap.adapters のキー。ft_configの type と一致させる必要がある
local dap_name = 'php'

local default_port = 9003

-- php-debug-adapter はNode.js製なので、実行ファイルではなく
-- phpDebug.js を node で起動する
local executable_path = envutil.join_path(
  vim.fn.stdpath('data'),
  'mason',
  'packages',
  mason_package,
  --mason_package .. ".cmd"
  'extension',
  'out',
  'phpDebug.js'
)

-- 起動にはMasonが作るシムを使う (中身は node phpDebug.js %*)
-- command='node' 直接指定は不可: このマシンのnodeはmiseのshim (node.cmd) で
-- node.exe がPATHにないため uv.spawn がENOENTになる
local shim_path = envutil.join_path(
  vim.fn.stdpath('data'),
  'mason',
  'packages',
  mason_package,
  mason_package .. (envutil.is_windows() and '.cmd' or '')
)

local config = {
  -- 複数指定することもできる
  -- 複数あるとデバッグ開始時にどの設定使うか聞かれる
  {
    -- なくてもいい。複数の設定があるとき、それらを識別するための名前
    name = 'Listen for Xdebug',

    -- dap.adapters にあるデバッガから、どれを使うか
    type = dap_name,

    -- Xdebugからの接続を待ち受ける
    request = 'launch',

    -- Xdebug 3 のデフォルトポート (php.ini の xdebug.client_port と合わせる)
    port = default_port,
  },
  {
    -- 開いているスクリプトを直接実行してデバッグする
    name = 'Launch current script',
    type = dap_name,
    request = 'launch',
    program = '${file}',
    cwd = '${fileDirname}',

    -- 0にすると空いているポートを自動で使う
    port = 0,
    runtimeArgs = { '-dxdebug.start_with_request=yes' },
  },
}

local ft_list = {
  "php",
  "blade",
}

--- @type my_adapter_config
local M = {
  executable_path = executable_path,
  port = default_port,
  name = dap_name,

  ft = ft_list,
  adapter_config = {
    -- phpDebug.js はstdioでDAPを話すので server ではなく executable
    -- server にすると nvim-dap がTCPで接続しに行き、誰もlistenしていないので
    -- ECONNREFUSED になる (ここのportはXdebugの9003とは別物のDAP用ポート)
    type = 'executable',
    command = shim_path,
    options = {
      -- nvim-dapのデフォルトは detached=true だが、Windowsでは .cmd を
      -- detachedで起動するとstdioが繋がらず initialize に応答しないため
      -- "Debug adapter didn't respond" になる
      detached = false,
    },
  },
  ft_config = util.make_ft_config_table(ft_list, config),
}

return M
