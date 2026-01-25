require("const.colour._type")

local primary_bg = "#132345"
local primary_fg = "#D8D8D8"

--local secondary_bg = "#16437d"
--local secondary_fg = "#F2F2F2"
local secondary_bg = "#132345"
local secondary_fg = "#F2F2F2"

local accent_bg = "#b1d1fa"
local accent_fg = "#1a1a1a"

local accent2_bg = accent_fg
local accent2_fg = accent_bg

local sub1_bg = "#345891"
local sub1_fg = "#1a1a1a"

local sub2_bg = "#97b9f0"
local sub2_fg = "#1a1a1a"

local sub3_bg = "#b1d1fa"
local sub3_fg = "#1a1a1a"

local terminal_bg = "#2f446e"
local terminal_fg = "#D8D8D8"

local azure = {
  transparent = {
    bg = "none",
    ctermbg = "none",
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
    primary =   { bg = primary_bg ,   fg = primary_fg },
    secondary = { bg = secondary_bg,  fg = secondary_fg },
    accent =    { bg = accent_bg,     fg = accent_fg },
    accent2 =   { bg = accent2_bg,    fg = accent2_fg },
    sub1 =      { bg = sub1_bg,       fg = sub1_fg },
    sub2 =      { bg = sub2_bg,       fg = sub2_fg },
    sub3 =      { bg = sub3_bg,       fg = sub3_fg },
    terminal =  { bg = terminal_bg,   fg = terminal_fg },
  },
}

return azure
