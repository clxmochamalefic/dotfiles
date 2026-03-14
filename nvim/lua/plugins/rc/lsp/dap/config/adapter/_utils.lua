-- ---------------------------------------------------------------------------
-- UTILITIES - DAP
-- ---------------------------------------------------------------------------

local envutil = require("utils.env");

---
--- 指定した複数のファイルタイプに対して、指定した同一の設定テーブルを与えて返す
---
--- @param ft_list string[] ファイルタイプのリスト
--- @param config table 設定テーブル
---
--- @return table ファイルタイプをキー、設定テーブルを値とするテーブル
---
local function make_ft_config_table(ft_list, config)
  local t = {}
  for _, ft in ipairs(ft_list) do
    t[ft] = config
  end
  return t
end

---
--- DAPの実行ファイルのパスを返す
---
--- @param dap_name string DAPの名前
--- @param last_dirname string? DAPの実行ファイルが入っている
---
--- @return string DAPの実行ファイルのパス
---
local function get_executable_path(dap_name, last_dirname)
  local basepath = vim.fn.stdpath('data')
  local last_dirname = last_dirname and last_dirname or 'bin'
  local ext = (envutil.is_windows() and '.exe' or '')

  -- path文字列のビルド、環境によって区切り文字を自動で変更
  local build_path = envutil.join_path(
    basepath,
    'mason',
    'packages',
    dap_name,
    'extension',
    last_dirname,
    dap_name .. ext
  )

  return build_path
end

return {
  make_ft_config_table = make_ft_config_table,
  get_executable_path = get_executable_path,
}

