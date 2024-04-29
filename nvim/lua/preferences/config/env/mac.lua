-- ---------------------------------------------------------------------------
--  FOR MACOS PREFERENCES
-- ---------------------------------------------------------------------------

local myutils = require("utils")

local M = {}

function M.setup()
  if myutils.env.is_mac() then
    M.setup_clipboard()
  end
end

function M.setup_clipboard()
  vim.opt.clipboard = "unnamedplus"
  vim.g.clipboard = {
    name = "macOS-clipboard",
    copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
    paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
    cache_enabled = 1,
  }
end

return M
