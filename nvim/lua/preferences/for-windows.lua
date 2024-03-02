-- ---------------------------------------------------------------------------
--  FOR WINDOWS PREFERENCES
-- ---------------------------------------------------------------------------

local myutils = require("utils")

local M = {}

function M.setup()
  M.setup_clipboard()
end

function M.setup_clipboard()
  if myutils.env.is_wsl() then
    vim.opt.clipboard = "unnamed"
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
      cache_enable = 0,
    }
  end
end

return M
