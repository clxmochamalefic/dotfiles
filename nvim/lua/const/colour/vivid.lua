require("const.colour._type")

local primary_bg = "#2F0B3A"
local primary_fg = "#D8D8D8"

local secondary_bg = "#610B5E"
local secondary_fg = "#F2F2F2"

local accent_bg = "#FEB2FC"
local accent_fg = "#D8D8D8"

local sub1_bg = "#961ea8"
local sub1_fg = "#D8D8D8"

local sub2_bg = "#dc92ff"
local sub2_fg = "#F2F2F2"

local sub3_bg = "#FEB2FC"
local sub3_fg = "#D8D8D8"

local terminal_bg = "#191d30"
local terminal_fg = "#D8D8D8"


local vivid = {
  transparent = {
    bg = "none",
    --fg = "none",
  },
  -- cui
  c = {
    zero = 0,
    bg = 249,
    fg = 46,
  },
  -- gui
  g = {
    primary = { bg = primary_bg , fg = primary_fg },
    secondary = { bg = secondary_bg, fg = secondary_fg },
    accent = { bg = accent_bg, fg = accent_fg },
    sub1 = { bg = sub1_bg, fg = sub1_fg },
    sub2 = { bg = sub2_bg, fg = sub2_fg },
    sub3 = { bg = sub3_bg, fg = sub3_fg },
    terminal = { bg = terminal_bg, fg = terminal_fg },
  },
}

return vivid
