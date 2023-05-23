-- ---------------------------------------------------------------------------
--  COLORSCHEME PREFERENCE

local colour = {}

local utils = require("utils")

local opt = vim.opt
local fn = vim.fn
local api = vim.api
local g = vim.g

colour.setup = function()
  -- using colorscheme
  -- api.nvim_exec([[
  -- try
  --   colorscheme onehalfdark
  -- catch /^Vim\%((\a\+)\)\=:E185/
  --   colorscheme default
  --   set background=dark
  -- endtry
  -- ]], false)

  local colorscheme = "onehalfdark"

  utils.try_catch({
    try = function()
      vim.cmd("colorscheme " .. colorscheme)
    end,
    catch = function()
      vim.cmd("colorscheme " .. "default")
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
  local opc                 = {
    ctermzero = 0,
    ctermbg = 249,
    ctermfg = 46,
    default = {
      guibg = "#2F0B3A", guifg = "#D8D8D8"
    },
    sub1 = {
      guibg = "#610B5E", guifg = "#F2F2F2"
    },
    sub2 = {
      guibg = "#FEB2FC", guifg = "#D8D8D8"
    },
    sub3 = {
      guibg = "#dc92ff", guifg = "#F2F2F2"
    }
  }

  local opc_default         = { ctermbg = opc.ctermbg, ctermfg = opc.ctermfg, guibg = opc.default.guibg,
    guifg = opc.default.guifg }
  local opc_sub1            = { ctermbg = opc.ctermbg, ctermfg = opc.ctermfg, guibg = opc.sub1.guibg,
    guifg = opc.sub1.guifg }
  local opc_sub2            = { ctermbg = opc.ctermbg, ctermfg = opc.ctermfg, guibg = opc.sub2.guibg,
    guifg = opc.sub2.guifg }
  local opc_sub3            = { ctermbg = opc.ctermbg, ctermfg = opc.ctermfg, guibg = opc.sub3.guibg,
    guifg = opc.sub3.guifg }

  --  modify line number col color
  local onepoint_augroup_id = api.nvim_create_augroup('MyColorSchemeOnePointModify', { clear = true })
  api.nvim_create_autocmd('ColorScheme', {
    group = onepoint_augroup_id,
    pattern = '*',
    callback = function()
      fn.highlight('LineNr', { ctermbg = opc.ctermfg, ctermfg = opc.ctermzero })
      fn.highlight('CursorLineNr', { ctermbg = opc.ctermbg, ctermfg = opc.ctermfg })
    end
  })

  local modify_color_for_comp_augroup_id = api.nvim_create_augroup('ModifyColorForComp', { clear = true })
  api.nvim_create_autocmd('ColorScheme', {
    group = modify_color_for_comp_augroup_id,
    callback = function()
      fn.highlight("RegistersWindow", opc_default)
      fn.highlight("Pmenu", opc_default)
      fn.highlight("PmenuSel", opc_sub1)
      fn.highlight("PmenuSbar", opc_sub2)
      fn.highlight("PmenuThumb", opc_sub3)
    end
  })

  local modify_color_for_float_wnd_augroup_id = api.nvim_create_augroup('ModifyColorForFloatWindow', { clear = true })
  api.nvim_create_autocmd('ColorScheme', {
    group = modify_color_for_float_wnd_augroup_id,
    callback = function()
      fn.highlight("NormalFloat", opc_default)
      fn.highlight("FloatBorder", opc_default)
    end
  })

  local modify_color_for_term_augroup_id = api.nvim_create_augroup('ModifyColorForTerm', { clear = true })
  api.nvim_create_autocmd('ColorScheme', {
    group = modify_color_for_term_augroup_id,
    callback = function()
      fn.highlight("TermCursor", opc_sub1)
      fn.highlight("TermCursorNC", opc_default)
    end
  })

  local opc_none = { ctermbg = "none", guibg = "none" }
  local transparent_bg_augroup_id = api.nvim_create_augroup('TransparentBG', { clear = true })
  api.nvim_create_autocmd('ColorScheme', {
    group = transparent_bg_augroup_id,
    pattern = '*',
    callback = function()
      fn.highlight("Normal", opc_none)
      fn.highlight("NonText", opc_none)
      fn.highlight("LineNr", opc_none)
      fn.highlight("Folded", opc_none)
      fn.highlight("EndOfBuffer", opc_none)
    end
  })

  --  modify color by colorscheme
  if colorscheme == "onehalfdark" then
    g.terminal_color_0 = '#565F70'
    g.terminal_color_8 = '#717C91'
  end
end

return colour

