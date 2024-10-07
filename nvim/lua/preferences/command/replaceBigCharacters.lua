-- ----------------------------------------
-- replace to big characters recent input
-- ----------------------------------------

local fn = function ()
    local line = vim.fn.getline(".")
    local col = vim.fn.getpos(".")[3]
    local substring = line:sub(1, col - 1)
    local result = vim.fn.matchstr(substring, [[\v<(\k(<)@!)*$]])
    return "<C-w>" .. result:upper()
  end
end

local M = {
  mode = "i",
  shortcut = "<C-k>",
  handler = fn,
  options = {expr = true},
}

M.setup = function()
  vim.keymap.set(M.mode, M.shortcut, M.handler, M.options)
end

return M
