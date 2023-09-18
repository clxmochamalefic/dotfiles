local g = vim.g
local fn = vim.fn
local api = vim.api
local keymap = vim.keymap

local M = {}

function M.get_vim_lines()
  return api.nvim_eval("&lines")
end

function M.get_vim_columns()
  return api.nvim_eval("&columns")
end

function M.resize_float_window_default()
  M.resize_float_window(8, 30)
end
function M.resize_float_window(col, height)
  g.float_window_col    = col
  g.float_window_height = height
  g.float_window_row    = M.get_vim_lines()   - g.float_window_height - 2
  g.float_window_width  = M.get_vim_columns() - (g.float_window_col * 2)
end

return M

