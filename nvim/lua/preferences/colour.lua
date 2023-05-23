-- ---------------------------------------------------------------------------
--  COLORSCHEME PREFERENCE

local colour = {}

local utils = require("utils")

local opt = vim.opt
local fn = vim.fn
local api = vim.api
local g = vim.g
local hl = vim.highlight

colour.setup = function()
  utils.begin_debug("colour")

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

  -- onepoint colors
  local opc = {
    ctermzero = 0,
    ctermbg   = 249,
    ctermfg   = 46,
    primary   = { guibg = "#2F0B3A", guifg = "#D8D8D8" },
    secondary = { guibg = "#610B5E", guifg = "#F2F2F2" },
    sub2      = { guibg = "#FEB2FC", guifg = "#D8D8D8" },
    sub3      = { guibg = "#dc92ff", guifg = "#F2F2F2" },
  }

  local opc_primary   = { ctermbg = opc.ctermbg, ctermfg = opc.ctermfg, guibg = opc.primary.guibg,    guifg = opc.primary.guifg }
  local opc_secondary = { ctermbg = opc.ctermbg, ctermfg = opc.ctermfg, guibg = opc.secondary.guibg,  guifg = opc.secondary.guifg }
  local opc_sub2      = { ctermbg = opc.ctermbg, ctermfg = opc.ctermfg, guibg = opc.sub2.guibg,       guifg = opc.sub2.guifg }
  local opc_sub3      = { ctermbg = opc.ctermbg, ctermfg = opc.ctermfg, guibg = opc.sub3.guibg,       guifg = opc.sub3.guifg }

  --  modify line number col color
  local onepoint_augroup_id = api.nvim_create_augroup('MyColorScheme', { clear = true })
  api.nvim_create_autocmd('ColorScheme', {
    group = onepoint_augroup_id,
    pattern = '*',
    callback = function()
      -- LineNumber
      hl.create('LineNr',        { ctermbg = opc.ctermfg, ctermfg = opc.ctermzero })
      hl.create('CursorLineNr',  { ctermbg = opc.ctermbg, ctermfg = opc.ctermfg })

      -- TransparentBG
      local opc_none = { ctermbg = "none", guibg = "none" }
      hl.create("Normal",       opc_none)
      hl.create("NonText",      opc_none)
      hl.create("LineNr",       opc_none)
      hl.create("Folded",       opc_none)
      hl.create("EndOfBuffer",  opc_none)
    end
  })

  local myhighlight_augroup_id = api.nvim_create_augroup('MyHighlight', { clear = true })
  api.nvim_create_autocmd('ColorScheme', {
    group = myhighlight_augroup_id,
    callback = function()
      -- pmenus
      hl.create("RegistersWindow", opc_primary,   false)
      hl.create("Pmenu",           opc_primary,   false)
      hl.create("PmenuSel",        opc_secondary, false)
      hl.create("PmenuSbar",       opc_sub2,      false)
      hl.create("PmenuThumb",      opc_sub3,      false)

      -- floating window
      hl.create("NormalFloat", opc_primary,       false)
      hl.create("FloatBorder", opc_primary,       false)

      -- terminal window
      hl.create("TermCursor", opc_secondary,      false)
      hl.create("TermCursorNC", opc_primary,      false)
    end
  })

  --  modify color by colorscheme
  if colorscheme == "onehalfdark" then
    g.terminal_color_0 = '#565F70'
    g.terminal_color_8 = '#717C91'
  end

  utils.end_debug("colour")
end

return colour

