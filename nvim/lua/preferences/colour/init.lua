-- ---------------------------------------------------------------------------
--  COLORSCHEME PREFERENCE
--  cterm colors => https://www.ditig.com/publications/256-colors-cheat-sheet
-- ---------------------------------------------------------------------------

local utils = require("utils")
local try_catch = require("utils.try_catch")
local _env = require("utils.env")
--- @module colour
local _c = require("utils.colour")

local _COLOUR = require("const.colour")
local _COLOUR_AZURE = require("const.colour.azure")
local theme = _COLOUR.get_mytheme_color_table(_COLOUR_AZURE)

local notify = require("preferences.colour.sub.notify")

----local set_highlight = vim.hi.create
--local set_highlight = nil
--
--local onepoint_colours_primary        = theme.primary
--local onepoint_colours_secondary      = theme.secondary
--local onepoint_colours_accent         = theme.accent
--local onepoint_colours_sub            = theme.sub
--
----local linenr   = onepoint_colours_transparent
----local linenr   = theme.transparent
----linenr.g.fg = theme.accent2.g.fg

local onepoint_colours_term     = theme.terminal
local onepoint_colours_term_nc  = { fg = "gray" }

local opc_pmenu                 = { bg = theme.secondary.g.bg, fg = theme.secondary.g.fg }
local opc_pmenu_sel             = { bg = theme.accent.g.bg, fg = theme.secondary.g.fg }
local opc_pmenu_sbar            = { bg = theme.secondary.g.bg, fg = theme.secondary.g.fg }
local opc_pmenu_thumb           = { bg = theme.accent.g.bg, fg = theme.secondary.g.fg }

--if not _env.is_nvim_version_gt_08() then
--  -- nvim0.8以前の設定
--  onepoint_colours_primary     = {
--    ctermbg = theme.primary.c.bg,
--    ctermfg = theme.primary.c.fg,
--    guibg   = theme.primary.g.bg,
--    guifg   = theme.primary.g.fg,
--  }
--  onepoint_colours_secondary   = {
--    ctermbg = theme.secondary.c.bg,
--    ctermfg = theme.secondary.c.fg,
--    guibg   = theme.secondary.g.bg,
--    guifg   = theme.secondary.g.fg,
--  }
--  onepoint_colours_accent      = {
--    ctermbg = theme.accent.c.bg,
--    ctermfg = theme.accent.c.fg,
--    guibg = theme.accent.g.bg,
--    guifg = theme.accent.g.fg,
--  }
--  onepoint_colours_sub        = {
--    ctermbg = theme.sub.c.bg,
--    ctermfg = theme.sub.c.fg,
--    guibg = theme.sub.g.bg,
--    guifg = theme.sub.g.fg,
--  }
--  onepoint_colours_sub3        = {
--    --ctermbg = theme.c.bg,
--    --ctermfg = theme.c.fg,
--    guibg = theme.sub3.g.bg,
--    guifg = theme.sub3.g.fg,
--  }
--  onepoint_colours_transparent = {
--    --ctermbg = theme.transparent.g.bg,
--    guibg = "None",
--  }
--
--  onepoint_colours_term        = {
--    ctermbg = theme.terminal.c.bg,
--    ctermfg = theme.terminal.c.fg,
--    guibg   = theme.terminal.g.bg,
--    guifg   = theme.terminal.g.fg,
--  }
--  onepoint_colours_term_nc     = { guifg = "gray" }
--
--  opc_pmenu                    = {
--    ctermbg = theme.secondary.c.bg,
--    ctermfg = theme.secondary.c.fg,
--    guibg   = theme.secondary.g.bg,
--    guifg   = theme.secondary.g.fg
--  }
--  opc_pmenu_sel                = {
--    ctermbg = theme.accent.c.bg,
--    ctermfg = theme.accent.c.fg,
--    guibg   = theme.accent.g.bg,
--    guifg   = theme.accent.g.fg
--  }
--  opc_pmenu_sbar               = {
--    ctermbg = theme.c.bg,
--    ctermfg = theme.c.fg,
--    guibg   = theme.secondary.g.bg,
--    guifg   = theme.secondary.g.fg
--  }
--  opc_pmenu_thumb              = {
--    ctermbg = theme.accent.c.bg,
--    ctermfg = theme.accent.c.fg,
--    guibg   = theme.accent.g.bg,
--    guifg   = theme.accent.g.fg
--  }
--
--  -- reference => https://stackoverflow.com/questions/2019281/load-different-colorscheme-when-using-vimdiff
--  -- DiffAdd    - line was added
--  --opc_diff_add                 = {
--  --  cterm = "bold",
--  --  --ctermfg = 10, -- Lime
--  --  --ctermbg = 22, -- DarkGreen
--  --  ctermfg = 253, -- Grey85
--  --  ctermbg = 31,  -- DeepSkyBlue3
--  --  guifg = "#dadada",
--  --  guibg = "#0087af",
--  --}
--  ---- DiffDelete - line was removed
--  --opc_diff_delete              = {
--  --  cterm = "bold",
--  --  ctermfg = 253, -- Grey85
--  --  ctermbg = 52,  -- DarkRed
--  --  guifg = "#dadada",
--  --  guibg = "#5f0000",
--  --}
--  ---- DiffChange - part of the line was changed (hls the whole line)
--  --opc_diff_changed             = {
--  --  cterm = "bold",
--  --  ctermfg = 253, -- Grey85
--  --  ctermbg = 54,  -- Purple4
--  --  guifg = "#dadada",
--  --  guibg = "#5f00af",
--  --}
--  ---- DiffText   - the exact part of the line that changed
--  ----            - 行の変更された正確な部分
--  --opc_diff_text                = {
--  --  cterm = "bold",
--  --  ctermfg = 15, -- White
--  --  ctermbg = 13, -- Fuchsia
--  --  guifg = "#ffffff",
--  --  guibg = "#ff00ff",
--  --}
--end

local M = {}




local function get_on_terminal()
  local normal = _c.build_hl_table("Normal", onepoint_colours_transparent)
  return {
    _c.build_hl_table("Normal", onepoint_colours_transparent)
  , _c.build_hl_table("NonText", onepoint_colours_transparent)
  --, _c.build_hl_table("LineNr", linenr)
  , _c.build_hl_table("CursorLineNr", onepoint_colours_secondary)
  , _c.build_hl_table("Folded", onepoint_colours_transparent)
  , _c.build_hl_table("EndOfBuffer", onepoint_colours_transparent)

  -- whitespace tab linebreak characters
--  , build_hl_table("NonText", {    ctermbg="None", ctermfg="242", bg="None", fg="#777" })
--  , build_hl_table("SpecialKey", { ctermbg="None", ctermfg="242", bg="None", fg="#777" })
  , _c.build_hl_table("NonText", {    bg="None", fg="#777777" })
  , _c.build_hl_table("SpecialKey", { bg="None", fg="#777777" })

  , _c.build_hl_table("WinBar", onepoint_colours_transparent)
  , _c.build_hl_table("WinBarNC", onepoint_colours_transparent)
  --, build_hl_table("SagaNormal", onepoint_colours_transparent)
  --, build_hl_table("SagaBorder", onepoint_colours_transparent)
  --,

  -- telescope.nvim
  , _c.build_hl_table("TelescopeNormal", onepoint_colours_transparent)

  -- winseparator
  , _c.build_hl_table("WinSeparator", onepoint_colours_transparent)
  ,


    _c.build_hl_table("RegistersWindow", onepoint_colours_primary)
  , _c.build_hl_table("Pmenu", opc_pmenu)
  , _c.build_hl_table("PmenuSel", opc_pmenu_sel)
  , _c.build_hl_table("PmenuSbar", opc_pmenu_sbar)
  , _c.build_hl_table("PmenuThumb", opc_pmenu_thumb)

  , _c.build_hl_table("NormalFloat", onepoint_colours_secondary)
  , _c.build_hl_table("FloatBorder", onepoint_colours_secondary)
  , _c.build_hl_table("FloatShadow", onepoint_colours_secondary)
  , _c.build_hl_table("FloatShadowThrough", onepoint_colours_secondary)

  , _c.build_hl_table("TermCursor", onepoint_colours_secondary)
  , _c.build_hl_table("TermCursorNC", onepoint_colours_primary)

  , _c.build_hl_table("Floaterm", onepoint_colours_term)
  , _c.build_hl_table("FloatermBorder", onepoint_colours_term)
  , _c.build_hl_table("FloatermNC", onepoint_colours_term_nc)
  }
end

M.get_my_colorscheme = function()
  utils.io.begin_debug("colour.get_my_colorscheme")
  local my_colorscheme = {}

  -- LineNumber
  -- table.insert(my_colorscheme, get_highlight_table("LineNr", onepoint_colours_secondary))
  table.insert(my_colorscheme, _c.build_hl_table("CursorLineNr", onepoint_colours_secondary))

  -- TransparentBG
  if not _env.is_neovide() then
    local on_terminal = get_on_terminal()
    my_colorscheme = vim.tbl_deep_extend("force", my_colorscheme, on_terminal)
  end


  utils.io.end_debug("colour.get_my_colorscheme")
  return my_colorscheme
end


M.setup = function()
  utils.io.begin_debug("colour.setup")

  local colorscheme = "onehalfdark"

  try_catch({
    try = function()
      vim.cmd("colorscheme " .. colorscheme)
    end,
    catch = function()
      --vim.cmd("colorscheme " .. "primary")
    end,
    finally = function()
      -- background color
      vim.opt.background = "dark"
    end,
  })

  --  hl cursor line
  vim.opt.cursorline = true

  --  define colorscheme load function for lazyload
  local my_colorscheme = M.get_my_colorscheme()
  local myhl_augroup_id = vim.api.nvim_create_augroup("Myhl", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = myhl_augroup_id,
    callback = function()
      _c.set_highlight_by_table(my_colorscheme)
    end,
  })

  utils.io.debug_echo("=== begin: default load ===")
  _c.set_highlight_by_table(my_colorscheme)
  utils.io.debug_echo("=== end: default load ===")

  --  modify color by colorscheme
  if colorscheme == "onehalfdark" then
    utils.io.debug_echo("overwrite terminal color")
    vim.g.terminal_color_0 = "#5A6A7C"
    vim.g.terminal_color_8 = "#8097B0"
  end

  notify.setup(my_colorscheme)

  utils.io.end_debug("colour.setup")
end

return M
