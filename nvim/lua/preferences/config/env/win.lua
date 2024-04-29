-- ---------------------------------------------------------------------------
--  FOR WINDOWS PREFERENCES
-- ---------------------------------------------------------------------------

local myutils = require("utils")

local M = {}

function M.setup()
  if myutils.env.is_wsl() or myutils.env.is_windows() then
    M.setup_clipboard()
  end
end

function M.setup_clipboard()
  vim.opt.clipboard = "unnamedplus"
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i",
      ["*"] = "win32yank.exe -i",
    },
    paste = {
      ["+"] = "win32yank.exe -o",
      ["*"] = "win32yank.exe -o",
    },
    cache_enabled = 1,
  }
end

return M
