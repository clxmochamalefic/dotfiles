local g = vim.g
local fn = vim.fn
local api = vim.api
local keymap = vim.keymap

local M = {}

function M.exists(name)
  return vim.uv.fs_stat(name)
  --local f = io.open(name, "r")
  --return f ~= nil and io.close(f)
end

function M.get_parent(path)
  return fn.fnamemodify(path, ':h')
end

function M.get_project_root_current_buf()
  -- 現在バッファのファイルの場所を起点に `.git` を上方向検索する
  -- (cwd 起点だと cwd 直下に .git がない場合に配下ツリー全体が
  --  検索対象になり telescope が数万ファイルを取り込んでしまう)
  local base = ""
  if vim.bo.buftype == "" then
    base = fn.expand('%:p:h')
  end
  if base == "" or not M.exists(base) then
    base = fn.getcwd()
  end
  return M.get_parent(fn.finddir('.git', base .. ";"))
end

return M

