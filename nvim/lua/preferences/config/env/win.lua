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
  if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
      name = "win32yank-wsl",
      copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
      },
      paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
      },
      cache_enabled = 0,
    }
  end
end

return M
