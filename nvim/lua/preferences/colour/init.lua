-- ---------------------------------------------------------------------------
--  COLORSCHEME PREFERENCE

local utils = require("utils")
local colours = require("const.colour")
local theme = colours.azure

local opt = vim.opt
local fn = vim.fn
local api = vim.api
local g = vim.g
local hl_define = vim.highlight.create

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
local onepoint_colours_none = {}
local onepoint_colours_term = {}
local onepoint_colours_term_nc = {}

if is_nvim_version_gt_08 then
  onepoint_colours_cui_primary = { bg = theme.g.primary.bg, fg = theme.g.primary.fg }
  onepoint_colours_cui_secondary = { bg = theme.g.sub3.bg, fg = theme.g.sub3.fg }
  onepoint_colours_primary = theme.g.primary
  onepoint_colours_secondary = theme.g.secondary
  onepoint_colours_sub2 = theme.g.sub2
  onepoint_colours_sub3 = theme.g.sub3
  onepoint_colours_none = theme.cn

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
  onepoint_colours_none = { ctermbg = theme.cn.bg, ctermfg = theme.cn.fg }

  onepoint_colours_term = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.terminal.bg,
    guifg = theme.g.terminal.fg,
  }
  onepoint_colours_term_nc = { guifg = "gray" }
end

local colour = {}

colour.get_my_colorscheme = function()
  utils.io.begin_debug("colour.get_my_colorscheme")
  local my_colorscheme = {}

  if is_nvim_version_gt_08 then
    utils.io.debug_echo("nvim-version: 0.8")
    -- LineNumber
    -- table.insert(my_colorscheme, { 0, 'LineNr',       onepoint_colours_cui_primary })
    table.insert(my_colorscheme, { 0, "CursorLineNr", onepoint_colours_cui_secondary })
    -- -- TransparentBG
    -- table.insert(my_colorscheme, { 0, "Normal",       onepoint_colours_none })
    -- table.insert(my_colorscheme, { 0, "NonText",      onepoint_colours_none })
    -- table.insert(my_colorscheme, { 0, "LineNr",       onepoint_colours_none })
    -- table.insert(my_colorscheme, { 0, "Folded",       onepoint_colours_none })
    -- table.insert(my_colorscheme, { 0, "EndOfBuffer",  onepoint_colours_none })
  else
    -- LineNumber
    -- table.insert(my_colorscheme, { 'LineNr',          onepoint_colours_cui_primary,   false })
    table.insert(my_colorscheme, { "CursorLineNr", onepoint_colours_cui_secondary, false })
    -- -- TransparentBG
    -- table.insert(my_colorscheme, { "Normal",          onepoint_colours_none,          false })
    -- table.insert(my_colorscheme, { "NonText",         onepoint_colours_none,          false })
    -- table.insert(my_colorscheme, { "LineNr",          onepoint_colours_none,          false })
    -- table.insert(my_colorscheme, { "Folded",          onepoint_colours_none,          false })
    -- table.insert(my_colorscheme, { "EndOfBuffer",     onepoint_colours_none,          false })
  end

  utils.io.end_debug("colour.get_my_colorscheme")
  return my_colorscheme
end

colour.get_highlight = function()
  utils.io.begin_debug("colour.get_highlight")
  local my_highlight = {}

  if is_nvim_version_gt_08 then
    utils.io.debug_echo("nvim-version: 0.8")
    -- pmenus
    table.insert(my_highlight, { 0, "RegistersWindow", onepoint_colours_primary })
    table.insert(my_highlight, { 0, "Pmenu", onepoint_colours_primary })
    table.insert(my_highlight, { 0, "PmenuSel", onepoint_colours_secondary })
    table.insert(my_highlight, { 0, "PmenuSbar", onepoint_colours_sub2 })
    table.insert(my_highlight, { 0, "PmenuThumb", onepoint_colours_sub3 })
    -- floating window
    table.insert(my_highlight, { 0, "NormalFloat", onepoint_colours_primary })
    table.insert(my_highlight, { 0, "FloatBorder", onepoint_colours_primary })
    table.insert(my_highlight, { 0, "FloatShadow", onepoint_colours_primary })
    table.insert(my_highlight, { 0, "FloatShadowThrough", onepoint_colours_primary })
    -- terminal window
    table.insert(my_highlight, { 0, "TermCursor", onepoint_colours_secondary })
    table.insert(my_highlight, { 0, "TermCursorNC", onepoint_colours_primary })
    -- floaterm
    table.insert(my_highlight, { 0, "Floaterm", onepoint_colours_term })
    table.insert(my_highlight, { 0, "FloatermBorder", onepoint_colours_term })
    table.insert(my_highlight, { 0, "FloatermNC", onepoint_colours_term_nc })
  else
    -- pmenus
    table.insert(my_highlight, { "RegistersWindow", onepoint_colours_primary, false })
    table.insert(my_highlight, { "Pmenu", onepoint_colours_primary, false })
    table.insert(my_highlight, { "PmenuSel", onepoint_colours_secondary, false })
    table.insert(my_highlight, { "PmenuSbar", onepoint_colours_sub2, false })
    table.insert(my_highlight, { "PmenuThumb", onepoint_colours_sub3, false })
    -- floating window
    table.insert(my_highlight, { "NormalFloat", onepoint_colours_primary, false })
    table.insert(my_highlight, { "FloatBorder", onepoint_colours_primary, false })
    table.insert(my_highlight, { "FloatShadow", onepoint_colours_primary, false })
    table.insert(my_highlight, { "FloatShadowThrough", onepoint_colours_primary, false })
    -- terminal window
    table.insert(my_highlight, { "TermCursor", onepoint_colours_secondary, false })
    table.insert(my_highlight, { "TermCursorNC", onepoint_colours_primary, false })
    -- floaterm
    table.insert(my_highlight, { "Floaterm", onepoint_colours_term, false })
    table.insert(my_highlight, { "FloatermBorder", onepoint_colours_term, false })
    table.insert(my_highlight, { "FloatermNC", onepoint_colours_term_nc, false })
  end

  utils.io.end_debug("colour.get_highlight")
  return my_highlight
end

colour.setup = function()
  utils.io.begin_debug("colour.setup")

  local colorscheme = "onehalfdark"

  utils.try_catch({
    try = function()
      vim.cmd("colorscheme " .. colorscheme)
    end,
    catch = function()
      vim.cmd("colorscheme " .. "primary")
    end,
    finally = function()
      -- background color
      opt.background = "dark"
    end,
  })

  opt.termguicolors = true

  --  highlight cursor line
  opt.cursorline = true

  --  define colorscheme load function for lazyload
  local my_colorscheme = colour.get_my_colorscheme()
  local my_highlight = colour.get_highlight()

  local set_colorscheme = function()
    utils.io.debug_echo("set colorschemes")
    for i, x in pairs(my_colorscheme) do
      utils.io.debug_echo(i, x)
      hl_define(x[1], x[2], x[3])
    end
  end
  local set_highlight = function()
    utils.io.debug_echo("set highlights")
    for i, x in pairs(my_highlight) do
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

  local myhighlight_augroup_id = api.nvim_create_augroup("MyHighlight", { clear = true })
  api.nvim_create_autocmd("ColorScheme", {
    group = myhighlight_augroup_id,
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
