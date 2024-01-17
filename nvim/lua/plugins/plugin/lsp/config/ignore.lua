local tbl = require("utils.table")

local M = {}

M.suppressFileTypes = {
  "NvimTree",
  "NeogitCommitMessage",
  "toggleterm",
  "gitrebase",
}

function M.isShowable(t)
  local ft = vim.bo[t.buf].filetype
  --return ft ~= "NvimTree" and ft ~= "NeogitCommitMessage" and ft ~= "toggleterm"
  return not tbl.is_value_exists(M.suppressFileTypes, ft)
end

return M
