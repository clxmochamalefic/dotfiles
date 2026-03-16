-- ---------------------------------------------------------------------------
-- ONEPOINT COLOURS
-- ---------------------------------------------------------------------------

require("const.colour._types")

local TRANSPARENT     = "none"
local GUI_DEFAULT_FG  = "#DDDDDD"

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
          fg = GUI_DEFAULT_FG,
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
  gui_default_fg = GUI_DEFAULT_FG,
  get_mytheme_color_table = get_mytheme_color_table,
  get_pumblend = get_pumblend,
  get_winblend = get_winblend,
}

return M

