local g = vim.g
local fn = vim.fn
local api = vim.api
local keymap = vim.keymap

local strutil = require("utils.string")

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
  g.float_window_col = col
  g.float_window_height = height
  g.float_window_row = M.get_vim_lines() - g.float_window_height - 2
  g.float_window_width = M.get_vim_columns() - (g.float_window_col * 2)
end

function M.getBufnr(nr)
  return fn["bufnr"](nr or "%")
end

function M.getBufName(nr)
  return fn["bufname"](nr or "%")
end

function M.getBufPath(nr)
  return fn["fnamemodify"](fn["bufname"](nr or "%"), ":p")
end

--- Get shorten path
---
--- @param nr number | nil number of buffer
--- @param first number first part of path to not shorten
--- @param last number last part of path to not shorten
---
--- @return string shorten path
function M.getBufPathPartialyShorten(nr, first, last)
  local path = M.getBufPath(nr)
  if path == nil then
    return ""
  end

  local splitted_path = strutil.split(path, "/")
  local splitted_path_length = #splitted_path
  local shorten_path = ""

  for i, v in ipairs(splitted_path) do
    if i < first then
      shorten_path = shorten_path .. v .. "/"
      goto continue
    end
    if splitted_path_length - i < last then
      shorten_path = shorten_path .. v .. "/"
      goto continue
    end

    local shorten = v:sub(1, 1)
    shorten_path = shorten_path .. shorten .. "/"
    ::continue::
  end

  return shorten_path
end

return M
