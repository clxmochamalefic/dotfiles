-- ---------------------------------------------------------------------------
--  COLORSCHEME PREFERENCE

local utils = require("utils")

local opt = vim.opt
local fn = vim.fn
local api = vim.api
local g = vim.g
local hl_define = vim.highlight.create

local is_nvim_version_gt_08 = fn.has('nvim-0.8')

if is_nvim_version_gt_08 then
  hl_define = api.nvim_set_hl
end

-- onepoint colors
local opc = {
  -- cui
  c = {
    zero = 0,
    bg   = 249,
    fg   = 46,
  },
  cn = {
    bg   = "none",
    fg   = "none",
  },
  -- gui
  g = {
    primary   = { bg = "#2F0B3A", fg = "#D8D8D8" },
    secondary = { bg = "#610B5E", fg = "#F2F2F2" },
    sub2      = { bg = "#FEB2FC", fg = "#D8D8D8" },
    sub3      = { bg = "#dc92ff", fg = "#F2F2F2" },
    terminal  = { bg = "#191d30", fg = "#D8D8D8" },
  }
}

local opc_cui_primary   = {}
local opc_cui_secondary = {}
local opc_primary       = {}
local opc_secondary     = {}
local opc_sub2          = {}
local opc_sub3          = {}
local opc_none          = {}
local opc_term          = {}
local opc_term_nc       = {}

if is_nvim_version_gt_08 then
  opc_cui_primary   = { bg = opc.g.primary.bg, fg = opc.g.primary.fg }
  opc_cui_secondary = { bg = opc.g.sub3.bg,    fg = opc.g.sub3.fg }
  opc_primary       = opc.g.primary
  opc_secondary     = opc.g.secondary
  opc_sub2          = opc.g.sub2
  opc_sub3          = opc.g.sub3
  opc_none          = opc.cn

  opc_term          = opc.g.terminal
  opc_term_nc       = { fg = "gray" }
else
  opc_cui_primary   = { ctermbg = opc.c.fg,   ctermfg = opc.c.zero }
  opc_cui_secondary = { ctermbg = opc.c.bg,   ctermfg = opc.c.fg }
  opc_primary       = { ctermbg = opc.c.bg,   ctermfg = opc.c.fg, guibg = opc.g.primary.bg,    guifg = opc.g.primary.fg }
  opc_secondary     = { ctermbg = opc.c.bg,   ctermfg = opc.c.fg, guibg = opc.g.secondary.bg,  guifg = opc.g.secondary.fg }
  opc_sub2          = { ctermbg = opc.c.bg,   ctermfg = opc.c.fg, guibg = opc.g.sub2.bg,       guifg = opc.g.sub2.fg }
  opc_sub3          = { ctermbg = opc.c.bg,   ctermfg = opc.c.fg, guibg = opc.g.sub3.bg,       guifg = opc.g.sub3.fg }
  opc_none          = { ctermbg = opc.cn.bg,  ctermfg = opc.cn.fg }

  opc_term          = { ctermbg = opc.c.bg,   ctermfg = opc.c.fg, guibg = opc.g.terminal.bg,   guifg = opc.g.terminal.fg }
  opc_term_nc       = { guifg = "gray" }
end

local colour = {}

colour.get_my_colorscheme = function()
  utils.begin_debug("colour.get_my_colorscheme")
  local my_colorscheme = {}

  if is_nvim_version_gt_08 then
    utils.debug_echo("nvim-version: 0.8")
    -- LineNumber
    table.insert(my_colorscheme, { 0, 'LineNr',       opc_cui_primary })
    table.insert(my_colorscheme, { 0, 'CursorLineNr', opc_cui_secondary })
    -- -- TransparentBG
    -- table.insert(my_colorscheme, { 0, "Normal",       opc_none })
    -- table.insert(my_colorscheme, { 0, "NonText",      opc_none })
    -- table.insert(my_colorscheme, { 0, "LineNr",       opc_none })
    -- table.insert(my_colorscheme, { 0, "Folded",       opc_none })
    -- table.insert(my_colorscheme, { 0, "EndOfBuffer",  opc_none })
  else
    -- LineNumber
    table.insert(my_colorscheme, { 'LineNr',          opc_cui_primary,   false })
    table.insert(my_colorscheme, { 'CursorLineNr',    opc_cui_secondary, false })
    -- -- TransparentBG
    -- table.insert(my_colorscheme, { "Normal",          opc_none,          false })
    -- table.insert(my_colorscheme, { "NonText",         opc_none,          false })
    -- table.insert(my_colorscheme, { "LineNr",          opc_none,          false })
    -- table.insert(my_colorscheme, { "Folded",          opc_none,          false })
    -- table.insert(my_colorscheme, { "EndOfBuffer",     opc_none,          false })
  end

  utils.end_debug("colour.get_my_colorscheme")
  return my_colorscheme
end

colour.get_highlight = function()
  utils.begin_debug("colour.get_highlight")
  local my_highlight = {}

  if is_nvim_version_gt_08 then
    utils.debug_echo("nvim-version: 0.8")
    -- pmenus
    table.insert(my_highlight, { 0, "RegistersWindow",    opc_primary,  })
    table.insert(my_highlight, { 0, "Pmenu",              opc_primary,  })
    table.insert(my_highlight, { 0, "PmenuSel",           opc_secondary,})
    table.insert(my_highlight, { 0, "PmenuSbar",          opc_sub2,     })
    table.insert(my_highlight, { 0, "PmenuThumb",         opc_sub3,     })
    -- floating window
    table.insert(my_highlight, { 0, "NormalFloat",        opc_primary,  })
    table.insert(my_highlight, { 0, "FloatBorder",        opc_primary,  })
    table.insert(my_highlight, { 0, "FloatShadow",        opc_primary,  })
    table.insert(my_highlight, { 0, "FloatShadowThrough", opc_primary,  })
    -- terminal window
    table.insert(my_highlight, { 0, "TermCursor",         opc_secondary,})
    table.insert(my_highlight, { 0, "TermCursorNC",       opc_primary,  })
    -- floaterm
    table.insert(my_highlight, { 0, "Floaterm",           opc_term,     })
    table.insert(my_highlight, { 0, "FloatermBorder",     opc_term,     })
    table.insert(my_highlight, { 0, "FloatermNC",         opc_term_nc,  })
  else
    -- pmenus
    table.insert(my_highlight, { "RegistersWindow",       opc_primary,    false })
    table.insert(my_highlight, { "Pmenu",                 opc_primary,    false })
    table.insert(my_highlight, { "PmenuSel",              opc_secondary,  false })
    table.insert(my_highlight, { "PmenuSbar",             opc_sub2,       false })
    table.insert(my_highlight, { "PmenuThumb",            opc_sub3,       false })
    -- floating window
    table.insert(my_highlight, { "NormalFloat",           opc_primary,    false })
    table.insert(my_highlight, { "FloatBorder",           opc_primary,    false })
    table.insert(my_highlight, { "FloatShadow",           opc_primary,    false })
    table.insert(my_highlight, { "FloatShadowThrough",    opc_primary,    false })
    -- terminal window
    table.insert(my_highlight, { "TermCursor",            opc_secondary,  false })
    table.insert(my_highlight, { "TermCursorNC",          opc_primary,    false })
    -- floaterm
    table.insert(my_highlight, { "Floaterm",              opc_term,       false })
    table.insert(my_highlight, { "FloatermBorder",        opc_term,       false })
    table.insert(my_highlight, { "FloatermNC",            opc_term_nc,    false })
  end
  
  utils.end_debug("colour.get_highlight")
  return my_highlight
end

colour.setup = function()
  utils.begin_debug("colour.setup")

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
    end
  })

  opt.termguicolors     = true

  --  highlight cursor line
  opt.cursorline        = true

  --  define colorscheme load function for lazyload

  local my_colorscheme = colour.get_my_colorscheme()
  local my_highlight    = colour.get_highlight()

  local set_colorscheme = function()
    utils.debug_echo("set colorschemes")
    for i, x in pairs(my_colorscheme) do
      utils.debug_echo(i, x)
      hl_define(x[1], x[2], x[3])
    end
  end
  local set_highlight = function()
    utils.debug_echo("set highlights")
    for i, x in pairs(my_highlight) do
      utils.debug_echo(i, x)
      hl_define(x[1], x[2], x[3])
    end
  end

  --  modify line number col color
  local mycolorscheme_augroup_id = api.nvim_create_augroup('MyColorScheme', { clear = true })
  api.nvim_create_autocmd('ColorScheme', {
    group = mycolorscheme_augroup_id,
    pattern = '*',
    callback = set_colorscheme
  })

  local myhighlight_augroup_id = api.nvim_create_augroup('MyHighlight', { clear = true })
  api.nvim_create_autocmd('ColorScheme', {
    group = myhighlight_augroup_id,
    callback = set_highlight
  })

  utils.debug_echo("=== default load ===")
  set_colorscheme()
  utils.debug_echo("=== default load ===")
  set_highlight()

  --  modify color by colorscheme
  if colorscheme == "onehalfdark" then
    utils.debug_echo("overwrite terminal color")
    g.terminal_color_0 = '#565F70'
    g.terminal_color_8 = '#717C91'
  end

  utils.end_debug("colour.setup")
end

return colour

