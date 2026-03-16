require("const.colour._types")

local const = require("const.colour")

local _env = require("utils.env")
local _io = require("utils.io")

local is_nvim_version_gt_08 = vim.fn.has("nvim-0.8") == 1

local M = {
  set_highlight = is_nvim_version_gt_08 and vim.api.nvim_set_hl or vim.hl.create,
}

local function get_hl_table(key, val)
  if _env.is_nvim_version_gt_08() then
    return { 0, key, val }
  end

  return { key, val, false }
end


function M.set_highlight_by_table(hl_table)
  _io.debug_echo("set hls")
  for i, x in pairs(hl_table) do
    _io.debug_echo(i, x)
    vim.print(i, x)
    M.set_highlight(x[1], x[2], x[3])
  end
end

function M.set_highlight_by_link(key, link_name)
  _io.debug_echo("set hls")
  local t = { link = link_name }
  local x = get_hl_table(key, t)
  M.set_highlight(x[1], x[2], x[3])
end

--- 
--- @param tbl my_colour
--- @param key string
--- @param target "gui"|"cui"|"" gui: gui only, cui: cterm only, empty string: gui and cterm both
local function get_bg_transparent_color(tbl, key, target)
  tbl = tbl or {}
  local transparent_bg = "None"
  local r = {}

  if target == "gui" or target == "" then
    r.bg = transparent_bg
    r.fg = tbl.g[key].fg
  end
  if target == "cui" or target == "" then
    r.ctermbg = transparent_bg
    r.ctermfg = tbl.g[key].fg
  end

  if tbl.g[key] then
    r.ctermfg = tbl[key].c.ctermfg
    r.fg = tbl[key].ctermfg
  end

  return r
end

M.get_hl_table = get_hl_table
M.get_bg_transparent_color = get_bg_transparent_color

--M.set_highlight_by_table = set_highlight_by_table

return M
