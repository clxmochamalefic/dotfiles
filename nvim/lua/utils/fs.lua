local g = vim.g
local fn = vim.fn
local api = vim.api
local keymap = vim.keymap

local M = {}

function M.exists(name)
  local f = io.open(name, "r")
  return f ~= nil and io.close(f)
end

function M.get_parent(path)
  return fn.fnamemodify(path, ':h')
end

function M.get_project_root_current_buf()
  return M.get_parent(fn.finddir('.git', fn.getcwd() .. ";"))
end

return M

