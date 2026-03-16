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
  for k, v in pairs(t) do
    if type(v) == "my_colour_display_type" then
      new_t[k] = v
    elseif type(v) == "my_colour_pair" then
      new_t[k] = {
        c = {
          fg = CUI_DEFAULT.fg,
          bg = CUI_DEFAULT.bg,
        },
        g = {
          fg = v.fg,
          bg = v.bg,
        },
      }
    else
      new_t[k] = {
        c = {
          fg = CUI_DEFAULT.fg,
          bg = CUI_DEFAULT.bg,
        },
        g = {
          fg = v.fg,
          bg = TRANSPARENT,
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

