-- ---------------------------------------------------------------------------
-- ONEPOINT COLOURS
-- ---------------------------------------------------------------------------

require("const.colour._types")

local TRANSPARENT     = "none"
local GUI_WHITE_FG  = "#EEEEEE"
local GUI_BLACK_FG  = "#111111"
local AVG_THRESHOLD   = tonumber("BB", 16)

local CUI_DEFAULT = {
  zero = 0,
  bg = 249,
  fg = 46,
}

local BLEND = {
  value = 20,
  max = 100,
}

local function get_pumblend()
  return BLEND.value
end
local function get_winblend()
  return BLEND.max - get_pumblend()
end

---
--- テーマとして上書きする色のテーブルについて、足りないパラメータを補完して返す
---
--- @param t my_colour テーマの色のテーブル
---
--- @return my_colour_strict テーマの色のテーブル
---
local function get_mytheme_color_table(t)
  local new_t = {}
  -- @var k string key
  -- @var v my_colour_display_type|my_colour_pair|string key
  for k, v in pairs(t) do
    if v.g ~= nil then
      new_t[k] = v
    elseif v.bg ~= nil then
      new_t[k] = {
        c = {
          fg = CUI_DEFAULT.fg,
          bg = CUI_DEFAULT.bg,
        },
        g = {
          fg = v.fg,
          bg = v.bg == "" and TRANSPARENT or v.bg,
        },
      }
    else  -- @var v string
      --vim.print("r", v:sub(2, 3), "g", v:sub(4, 5), "b", v:sub(6, 7))
      local total = (tonumber(v:sub(2, 3), 16) + tonumber(v:sub(4, 5), 16) + tonumber(v:sub(6, 7), 16))
      local avg = total / 3
      --vim.print("key", k, "value", v)
      --vim.print("THRESHOLD", AVG_THRESHOLD)
      --vim.print("total", total)
      --vim.print("avg", avg)
      local gui_default_fg = avg > AVG_THRESHOLD and GUI_BLACK_FG or GUI_WHITE_FG
      new_t[k] = {
        c = {
          fg = CUI_DEFAULT.fg,
          bg = CUI_DEFAULT.bg,
        },
        g = {
          fg = v,
          bg = TRANSPARENT,
        },
      }
      new_t[k .. "_bg"] = {
        c = {
          fg = CUI_DEFAULT.fg,
          bg = CUI_DEFAULT.bg,
        },
        g = {
          fg = gui_default_fg,
          bg = v,
        },
      }
    end
  end

  return new_t
end

local M = {
  transparent = "None",
  blend = BLEND,
  gui_default_fg = GUI_WHITE_FG,
  get_mytheme_color_table = get_mytheme_color_table,
  get_pumblend = get_pumblend,
  get_winblend = get_winblend,
}

return M

