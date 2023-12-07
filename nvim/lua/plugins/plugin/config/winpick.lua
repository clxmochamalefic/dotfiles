local M = {}

function M.setup(opts)
  M.winpick = require("winpick")
  local defaults = {
    border = "double",
    filter = nil, -- doesn't ignore any window by default
    prompt = "Pick a window: ",
    format_label = M.winpick.defaults.format_label, -- formatted as "<label>: <buffer name>"
    chars = nil,
  }

  M.winpick.setup(vim.tbl_deep_extend("force", defaults, opts or {}))
end

function M.choose()
  local winid = M.winpick.select({ prompt = 'Pick a split...' })
  if winid then
    vim.api.nvim_set_current_win(winid)
  end
end

return M
