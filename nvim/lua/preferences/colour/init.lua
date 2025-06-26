-- ---------------------------------------------------------------------------
--  COLORSCHEME PREFERENCE
--  cterm colors => https://www.ditig.com/publications/256-colors-cheat-sheet
--
-- ---------------------------------------------------------------------------

local utils = require("utils")
local colours = require("const.colour")
local theme = colours.azure

local opt = vim.opt
local fn = vim.fn
local api = vim.api
local g = vim.g
local hl_define = vim.hl.create

local is_nvim_version_gt_08 = fn.has("nvim-0.8")

if is_nvim_version_gt_08 then
  hl_define = api.nvim_set_hl
end

local onepoint_colours_cui_primary = {}
local onepoint_colours_cui_secondary = {}
local onepoint_colours_primary = {}
local onepoint_colours_secondary = {}
local onepoint_colours_sub2 = {}
local onepoint_colours_sub3 = {}
local onepoint_colours_transparent = {}
local onepoint_colours_term = {}
local onepoint_colours_term_nc = {}

local opc_diff_add     = {}
local opc_diff_delete  = {}
local opc_diff_changed  = {}
local opc_diff_text    = {}



if is_nvim_version_gt_08 then
  onepoint_colours_cui_primary = { bg = theme.g.primary.bg, fg = theme.g.primary.fg }
  onepoint_colours_cui_secondary = { bg = theme.g.sub3.bg, fg = theme.g.sub3.fg }
  onepoint_colours_primary = theme.g.primary
  onepoint_colours_secondary = theme.g.secondary
  onepoint_colours_sub2 = theme.g.sub2
  onepoint_colours_sub3 = theme.g.sub3
  onepoint_colours_transparent = theme.transparent

  onepoint_colours_term = theme.g.terminal
  onepoint_colours_term_nc = { fg = "gray" }

else

  onepoint_colours_cui_primary = { ctermbg = theme.c.fg, ctermfg = theme.c.zero }
  onepoint_colours_cui_secondary = { ctermbg = theme.c.bg, ctermfg = theme.c.fg }
  onepoint_colours_primary = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.primary.bg,
    guifg = theme.g.primary.fg,
  }
  onepoint_colours_secondary = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.secondary.bg,
    guifg = theme.g.secondary.fg,
  }
  onepoint_colours_sub2 = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.sub2.bg,
    guifg = theme.g.sub2.fg,
  }
  onepoint_colours_sub3 = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.sub3.bg,
    guifg = theme.g.sub3.fg,
  }
  onepoint_colours_transparent = {
    ctermbg = theme.transparent.bg,
    guibg = theme.transparent.bg
  }

  onepoint_colours_term = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.terminal.bg,
    guifg = theme.g.terminal.fg,
  }
  onepoint_colours_term_nc = { guifg = "gray" }


  -- reference => https://stackoverflow.com/questions/2019281/load-different-colorscheme-when-using-vimdiff
  --
  -- cterm   - sets the style
  -- ctermfg - set the text color
  -- ctermbg - set the hling
  --
  -- DiffAdd    - line was added
  -- DiffDelete - line was removed
  -- DiffChange - part of the line was changed (hls the whole line)
  --            - 行の一部が変更されました（行全体を強調表示）
  -- DiffText   - the exact part of the line that changed
  --            - 行の変更された正確な部分

  opc_diff_add = {
    cterm = "bold",
    --ctermfg = 10, -- Lime
    --ctermbg = 22, -- DarkGreen
    ctermfg = 253, -- Grey85
    ctermbg = 31, -- DeepSkyBlue3
    guifg = "#dadada",
    guibg = "#0087af",
  }
  opc_diff_delete = {
    cterm = "bold",
    ctermfg = 253, -- Grey85
    ctermbg = 52, -- DarkRed
    guifg = "#dadada",
    guibg = "#5f0000",
  }
  opc_diff_changed  = {
    cterm = "bold",
    ctermfg = 253, -- Grey85
    ctermbg = 54, -- Purple4
    guifg = "#dadada",
    guibg = "#5f00af",
  }
  opc_diff_text    = {
    cterm = "bold",
    ctermfg = 15, -- White
    ctermbg = 13, -- Fuchsia
    guifg = "#ffffff",
    guibg = "#ff00ff",
  }
end

local colour = {}


local function get_hl_table(key, val)
  if is_nvim_version_gt_08 then
    return{ 0, key, val }
  end

  return { key, val, false }
end

colour.get_my_colorscheme = function()
  utils.io.begin_debug("colour.get_my_colorscheme")
  local my_colorscheme = {}

  -- LineNumber
  -- table.insert(my_colorscheme, get_highlight_table("LineNr", onepoint_colours_cui_secondary))
  table.insert(my_colorscheme, get_hl_table("CursorLineNr", onepoint_colours_cui_secondary))

  -- TransparentBG
  table.insert(my_colorscheme, get_hl_table("Normal", onepoint_colours_transparent))
  table.insert(my_colorscheme, get_hl_table("NonText", onepoint_colours_transparent))
  table.insert(my_colorscheme, get_hl_table("LineNr", onepoint_colours_transparent))
  table.insert(my_colorscheme, get_hl_table("Folded", onepoint_colours_transparent))
  table.insert(my_colorscheme, get_hl_table("EndOfBuffer", onepoint_colours_transparent))

  utils.io.end_debug("colour.get_my_colorscheme")
  return my_colorscheme
end

colour.get_hl = function()
  utils.io.begin_debug("colour.get_hl")

  local hl_table = {
    Normal =onepoint_colours_transparent,
    NonText =onepoint_colours_transparent,
    NormalNC =onepoint_colours_transparent,
    NormalSB =onepoint_colours_transparent,

    RegistersWindow = onepoint_colours_primary,
    Pmenu           = onepoint_colours_primary,
    PmenuSel        = onepoint_colours_secondary,
    PmenuSbar       = onepoint_colours_sub2,
    PmenuThumb      = onepoint_colours_sub3,

    NormalFloat = onepoint_colours_primary,
    FloatBorder = onepoint_colours_primary,
    FloatShadow = onepoint_colours_primary,
    FloatShadowThrough = onepoint_colours_primary,

    TermCursor = onepoint_colours_secondary,
    TermCursorNC = onepoint_colours_primary,

    Floaterm = onepoint_colours_term,
    FloatermBorder = onepoint_colours_term,
    FloatermNC = onepoint_colours_term_nc,

    DiffAdd         = opc_diff_add,
    DiffDelete      = opc_diff_delete,
    DiffChange      = opc_diff_changed,
    DiffText        = opc_diff_text,
  }


  local my_hl = {}

  for key, val in pairs(hl_table) do
    table.insert(my_hl, get_hl_table(is_nvim_version_gt_08, key, val))
  end

  utils.io.end_debug("colour.get_hl")
  return my_hl
end

colour.setup = function()
  utils.io.begin_debug("colour.setup")

  local colorscheme = "onehalfdark"

  utils.try_catch({
    try = function()
      vim.cmd("colorscheme " .. colorscheme)
    end,
    catch = function()
      --vim.cmd("colorscheme " .. "primary")
    end,
    finally = function()
      -- background color
      opt.background = "dark"
    end,
  })

  opt.termguicolors = true

  --  hl cursor line
  opt.cursorline = true

  --  define colorscheme load function for lazyload
  local my_colorscheme = colour.get_my_colorscheme()
  local my_hl = colour.get_hl()

  local set_colorscheme = function()
    utils.io.debug_echo("set colorschemes")
    for i, x in pairs(my_colorscheme) do
      utils.io.debug_echo(i, x)
      hl_define(x[1], x[2], x[3])
    end
  end
  local set_highlight = function()
    utils.io.debug_echo("set hls")
    for i, x in pairs(my_hl) do
      utils.io.debug_echo(i, x)
      hl_define(x[1], x[2], x[3])
    end
  end

  --  modify line number col color
  local mycolorscheme_augroup_id = api.nvim_create_augroup("MyColorScheme", { clear = true })
  api.nvim_create_autocmd("ColorScheme", {
    group = mycolorscheme_augroup_id,
    pattern = "*",
    callback = set_colorscheme,
  })

  local myhl_augroup_id = api.nvim_create_augroup("Myhl", { clear = true })
  api.nvim_create_autocmd("ColorScheme", {
    group = myhl_augroup_id,
    callback = set_highlight,
  })

  utils.io.debug_echo("=== default load ===")
  set_colorscheme()
  utils.io.debug_echo("=== default load ===")
  set_highlight()

  --  modify color by colorscheme
  if colorscheme == "onehalfdark" then
    utils.io.debug_echo("overwrite terminal color")
    g.terminal_color_0 = "#5A6A7C"
    g.terminal_color_8 = "#8097B0"
  end

  utils.io.end_debug("colour.setup")
end

return colour
