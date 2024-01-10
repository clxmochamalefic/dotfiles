-- ---------------------------------------------------------------------------
--  WINPICK CONFIG
-- ---------------------------------------------------------------------------

local g = vim.g
local fn = vim.fn
local uv = vim.uv
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local utils = require("utils")

local M = {}

local excluded_filetypes = {
  "nofile"
}

--
-- setup winpick config
-- @param opts options for winpick.setup() default is empty object => {}
--
function M.setup(opts)
  M.winpick = require("winpick")
  local defaults = {
    border = "double",
    filter = nil, -- doesn't ignore any window by default
    --filter = function(winid, bufnr)
    --  local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")

    --  if vim.tbl_contains(excluded_filetypes, buftype) then
    --    return false
    --  end

    --  return true
    --end,
    prompt = "Pick a window: ",
    format_label = M.winpick.defaults.format_label, -- formatted as "<label>: <buffer name>"
    --format_label = function(label, y, z)
    --  return string.format('%s', label)
    --end,
    chars = nil,
  }

  M.winpick.setup(vim.tbl_deep_extend("force", defaults, opts or {}))
end

--
-- choose window for window focus
--
function M.choose_for_focus()
  local winid = M.winpick.select()
  if winid then
    vim.api.nvim_set_current_win(winid)
  end
end

--
-- choose window for window move
--
function M.choose_for_move()
  local bufnr = fn["bufnr"]('%')
  local winid = M.winpick.select()
  if winid then
    vim.api.nvim_set_current_win(winid)
  end
end

return M
