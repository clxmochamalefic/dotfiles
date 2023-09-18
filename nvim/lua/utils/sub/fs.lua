local g = vim.g
local fn = vim.fn
local api = vim.api
local keymap = vim.keymap

local M = {}

function M.exists(name)
  local f = io.open(name, "r")
  return f ~= nil and io.close(f)
end

return M

