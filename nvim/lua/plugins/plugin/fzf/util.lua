-- ---------------------------------------------------------------------------
-- TELESCOPE UTILS
-- ---------------------------------------------------------------------------

local myutils = require("utils")

local M = {
  builtin = nil,
}

--
-- ファイル名と親ディレクトリをタブ区切りで表示する
--
-- @param path string: ファイルパス
--
function M.FileNameFirst(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)
  if parent == "." then
    return tail
  end
  return string.format("%s\t\t%s", tail, parent)

  --local splitted = myutils.string.split(parent, "/")
  --local reverse = {}
  --for _, v in ipairs(splitted) do
  --  table.insert(reverse, 1, v)
  --end
  --local inversePath = table.concat(reverse, ".")
  --return string.format("%s\t\t%s", tail, inversePath)
end

--
-- telescope.nvim ビルトインを取得する
-- 純粋に毎回 `require` 書くの面倒くさかった
--
function M.GetBuiltin()
  if M.builtin == nil then
    M.builtin = require("telescope.builtin")
  end
  return M.builtin
end

--
-- telescope builtin 向けのデフォルト設定
--
function M.GetDefaultOpts()
  return {
    search_dirs = { myutils.fs.get_project_root_current_buf() },
  }
end

--
-- telescope.nvim ビルトインの `find_files` をコールする
--
-- @param opts options: default => GetDefaultOpts()
--
function M.CallBuiltinFindFiles(opts)
  opts = opts or M.GetDefaultOpts()
  M.GetBuiltin().find_files(opts)
end
--
-- telescope.nvim ビルトインの `live_grep` をコールする
--
-- @param opts options: default => default_opts
--
function M.CallBuiltinLiveGrep(opts)
  opts = opts or M.GetDefaultOpts()
  M.GetBuiltin().live_grep(opts)
end
--
-- telescope.nvim 拡張の `live_grep_args` をコールする
--
-- @param opts options: default => GetDefaultOpts()
--
function M.CallBuiltinLiveGrepArgs(opts)
  opts = opts or M.GetDefaultOpts()
  require("telescope").extensions.live_grep_args.live_grep_args(opts)
end

--
-- telescope.nvim ビルトインの `buffer` をコールする
-- bufferの一覧をfzfする
--
-- @param opts options: default => default_opts
--
function M.CallBuiltinBuffer(opts)
  opts = opts or {}
  M.GetBuiltin().buffers(opts)
end

--
-- telescope.nvim 拡張の `help_tags` をコールする
-- vimヘルプをfzfする
--
-- @param opts options: default => default_opts
--
function M.CallBuiltinHelpTags(opts)
  opts = opts or {}
  M.GetBuiltin().help_tags(opts)
end

--
-- telescope.nvim 拡張の `frecency` をコールする
-- 開いた際のバッファのファイルが管理されている `.git` フォルダの位置を親フォルダとしてfzfする
--
-- @param opts options: default => default_opts
--
function M.CallFrecencyCurrentDir()
  local project_root = myutils.fs.get_project_root_current_buf()
  vim.cmd("Telescope frecency workspace=" .. project_root .. "<CR>")
end

return M
