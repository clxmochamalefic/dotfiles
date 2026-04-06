require("const.colour._types")

local primary_bg = "#132345"
local primary_fg = "#D8D8D8"

local secondary = "#16437d"

local accent = "#b1d1fa"
local sub = "#ffcc00"
local disabled = "#888888"

local terminal_bg = "#2f446e"
local terminal_fg = "#D8D8D8"

---
--- @class my_colour
---
local azure = {
    primary   = { bg = primary_bg ,   fg = primary_fg },
    secondary = secondary,
    accent    = accent,
    sub       = sub,
    terminal  = { bg = terminal_bg,   fg = terminal_fg },
    disabled  = disabled,
}

return azure
