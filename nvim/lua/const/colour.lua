-- ---------------------------------------------------------------------------
-- ONEPOINT COLOURS
-- ---------------------------------------------------------------------------

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
    primary = { bg = "#2F0B3A", fg = "#D8D8D8" },
    secondary = { bg = "#610B5E", fg = "#F2F2F2" },
    accent = { bg = "#FEB2FC", fg = "#D8D8D8" },
    sub1 = { bg = "#961ea8", fg = "#D8D8D8" },
    sub2 = { bg = "#dc92ff", fg = "#F2F2F2" },
    sub3 = { bg = "#FEB2FC", fg = "#D8D8D8" },
    terminal = { bg = "#191d30", fg = "#D8D8D8" },
  },
}

local azure = {
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

    --primary = { bg = "#16437d", fg = "#D8D8D8" },
    --secondary = { bg = "#345891", fg = "#F2F2F2" },
    --sub1 = { bg = "#7ea8e0", fg = "#1a1a1a" },
    primary = { bg = "#132345", fg = "#D8D8D8" },
    secondary = { bg = "#16437d", fg = "#F2F2F2" },
    accent = { bg = "#b1d1fa", fg = "#1a1a1a" },
    sub1 = { bg = "#345891", fg = "#1a1a1a" },
    sub2 = { bg = "#97b9f0", fg = "#1a1a1a" },
    sub3 = { bg = "#b1d1fa", fg = "#1a1a1a" },
    --terminal = { bg = "#191d30", fg = "#D8D8D8" },
    terminal = { bg = "#2f446e", fg = "#D8D8D8" },
  },
}

local transparent = {
}

local M = {
  vivid = vivid,
  azure = azure,
}

return M
