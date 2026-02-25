require("const.colour._type")

local const = require("const.colour")

local env = require("utils.env")

local M = {}

local function get_pumblend()
  return const.blend.value
end
local function get_winblend()
  return const.blend.max - get_pumblend()
end

local function get_hl_table(key, val)
  if env.is_nvim_version_gt_08() then
    return { 0, key, val }
  end

  return { key, val, false }
end

----- 
----- @param tbl # [my_colour]
----- @param key # [string]
----- @param target # ["gui"|"cui"|""] gui: gui only, cui: cterm only, empty string: gui and cterm both
--local function get_bg_transparent_color(tbl, key, target)
--  tbl = tbl or {}
--  local transparent_bg = "None"
--  local r = {}
--
--  if target == "gui" or target == "" then
--    r.bg = transparent_bg
--    r.fg = tbl.g.[key].fg
--  end
--  if target == "cui" or target == "" then
--    r.ctermbg = transparent_bg
--    r.ctermfg = tbl.g.[key].fg
--  end
--
--  if tbl.g.[key] then
--    r.ctermfg = tbl[key].c.ctermfg
--    r.fg = tbl[key].ctermfg
--  end
--
--  return r
--end

M.get_pumblend = get_pumblend
M.get_winblend = get_winblend
M.get_hl_table = get_hl_table
--M.get_bg_transparent_color = get_bg_transparent_color

return M
