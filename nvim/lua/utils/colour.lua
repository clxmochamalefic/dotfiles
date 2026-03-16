require("const.colour._types")

--local const = require("const.colour")
local _io = require("utils.io")

local env = require("utils.env")

local _set_highlight = nil

local M = {
  _is_nvim_version_gt_08 = nil,
  _set_highlight = nil,
}

local function is_nvim_version_gt_08()
  if (M._is_nvim_version_gt_08 == nil) then
    M._is_nvim_version_gt_08 = vim.fn.has("nvim-0.8") == 1
  end

  return M._is_nvim_version_gt_08
end

local function init_set_highlight()
  if not is_nvim_version_gt_08() then
    _set_highlight = vim.api.nvim_set_hl
  else
    _set_highlight = vim.hl.create
  end
end

local function set_highlight(arg1, arg2, arg3)
  if _set_highlight == nil then
    init_set_highlight()
  end

  if _set_highlight ~= nil then
    _set_highlight(arg1, arg2, arg3)
  end
end

local function set_highlight_by_table(hl_table)
  _io.debug_echo("set hls")
  for i, x in pairs(hl_table) do
    _io.debug_echo(i, x)
    M.set_highlight(x[1], x[2], x[3])
  end
end

local function build_hl_table(key, val)
  if env.is_nvim_version_gt_08() then
    return { 0, key, val }
  end

  return { key, val, false }
end

M.is_nvim_version_gt_08 = is_nvim_version_gt_08
M.set_highlight = set_highlight
M.set_highlight_by_table = set_highlight_by_table
--M.get_pumblend = get_pumblend
--M.get_winblend = get_winblend
M.build_hl_table = build_hl_table
--M.get_bg_transparent_color = get_bg_transparent_color

return M
