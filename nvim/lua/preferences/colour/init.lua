-- ---------------------------------------------------------------------------
--  COLORSCHEME PREFERENCE
--  cterm colors => https://www.ditig.com/publications/256-colors-cheat-sheet
-- ---------------------------------------------------------------------------

local utils = require("utils")
local env = require("utils..env")

local colours = require("const.colour")
local theme = colours.azure

local notify = require("preferences.colour.sub.notify")

--local set_highlight = vim.hi.create
local set_highlight = nil

local is_nvim_version_gt_08 = vim.fn.has("nvim-0.8") == 1
if is_nvim_version_gt_08 then
  set_highlight = vim.api.nvim_set_hl
else
  set_highlight = vim.hl.create
end

local onepoint_colours_cui_primary   = { bg = theme.g.primary.bg, fg = theme.g.primary.fg }
local onepoint_colours_cui_secondary = { bg = theme.g.sub3.bg, fg = theme.g.sub3.fg }
local onepoint_colours_primary       = theme.g.primary
local onepoint_colours_secondary     = theme.g.secondary
local onepoint_colours_accent        = theme.g.accent
local onepoint_colours_sub2          = theme.g.sub2
local onepoint_colours_sub3          = theme.g.sub3
local onepoint_colours_transparent   = theme.transparent

local onepoint_colours_term          = theme.g.terminal
local onepoint_colours_term_nc       = { fg = "gray" }

local opc_pmenu                      = { bg = theme.g.secondary.bg, fg = theme.g.secondary.fg }
local opc_pmenu_sel                  = { bg = theme.g.accent.bg, fg = theme.g.secondary.fg }
local opc_pmenu_sbar                 = { bg = theme.g.secondary.bg, fg = theme.g.secondary.fg }
local opc_pmenu_thumb                = { bg = theme.g.accent.bg, fg = theme.g.secondary.fg }

local opc_diff_add                   = { fg = "#dadada", bg = "#0087af", }
-- DiffDelete - line was removed
local opc_diff_delete                = { fg = "#dadada", bg = "#5f0000", }
-- DiffChange - part of the line was changed (hls the whole line)
local opc_diff_changed               = { fg = "#dadada", bg = "#5f00af", }
-- DiffText   - the exact part of the line that changed
--            - 行の変更された正確な部分
local opc_diff_text                  = { fg = "#ffffff", bg = "#ff00ff", }

if not is_nvim_version_gt_08 then
  -- nvim0.8以前の設定
  onepoint_colours_primary     = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.primary.bg,
    guifg = theme.g.primary.fg,
  }
  onepoint_colours_secondary   = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.secondary.bg,
    guifg = theme.g.secondary.fg,
  }
  onepoint_colours_accent      = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.accent.bg,
    guifg = theme.g.accent.fg,
  }
  onepoint_colours_sub2        = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.sub2.bg,
    guifg = theme.g.sub2.fg,
  }
  onepoint_colours_sub3        = {
    --ctermbg = theme.c.bg,
    --ctermfg = theme.c.fg,
    guibg = theme.g.sub3.bg,
    guifg = theme.g.sub3.fg,
  }
  onepoint_colours_transparent = {
    ctermbg = theme.transparent.bg,
    guibg = theme.transparent.bg
  }

  onepoint_colours_term        = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.terminal.bg,
    guifg = theme.g.terminal.fg,
  }
  onepoint_colours_term_nc     = { guifg = "gray" }

  opc_pmenu                    = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.secondary.bg,
    guifg = theme.g.secondary.fg
  }
  opc_pmenu_sel                = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.accent.bg,
    guifg = theme.g.secondary.fg
  }
  opc_pmenu_sbar               = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.secondary.bg,
    guifg = theme.g.secondary.fg
  }
  opc_pmenu_thumb              = {
    ctermbg = theme.c.bg,
    ctermfg = theme.c.fg,
    guibg = theme.g.accent.bg,
    guifg = theme.g.secondary.fg
  }

  -- reference => https://stackoverflow.com/questions/2019281/load-different-colorscheme-when-using-vimdiff
  -- DiffAdd    - line was added
  opc_diff_add                 = {
    cterm = "bold",
    --ctermfg = 10, -- Lime
    --ctermbg = 22, -- DarkGreen
    ctermfg = 253, -- Grey85
    ctermbg = 31,  -- DeepSkyBlue3
    guifg = "#dadada",
    guibg = "#0087af",
  }
  -- DiffDelete - line was removed
  opc_diff_delete              = {
    cterm = "bold",
    ctermfg = 253, -- Grey85
    ctermbg = 52,  -- DarkRed
    guifg = "#dadada",
    guibg = "#5f0000",
  }
  -- DiffChange - part of the line was changed (hls the whole line)
  opc_diff_changed             = {
    cterm = "bold",
    ctermfg = 253, -- Grey85
    ctermbg = 54,  -- Purple4
    guifg = "#dadada",
    guibg = "#5f00af",
  }
  -- DiffText   - the exact part of the line that changed
  --            - 行の変更された正確な部分
  opc_diff_text                = {
    cterm = "bold",
    ctermfg = 15, -- White
    ctermbg = 13, -- Fuchsia
    guifg = "#ffffff",
    guibg = "#ff00ff",
  }
end

local M = {}


local function set_highlight_by_table(hl_table)
  utils.io.debug_echo("set hls")
  for i, x in pairs(hl_table) do
    utils.io.debug_echo(i, x)
    set_highlight(x[1], x[2], x[3])
  end
end

local function get_hl_table(key, val)
  if is_nvim_version_gt_08 then
    return { 0, key, val }
  end

  return { key, val, false }
end

M.get_my_colorscheme = function()
  utils.io.begin_debug("colour.get_my_colorscheme")
  local my_colorscheme = {}

  -- LineNumber
  -- table.insert(my_colorscheme, get_highlight_table("LineNr", onepoint_colours_cui_secondary))
  table.insert(my_colorscheme, get_hl_table("CursorLineNr", onepoint_colours_cui_secondary))

  -- TransparentBG
  if not env.is_neovide() then -- TODO: neovide supportをここに書かない
    table.insert(my_colorscheme, get_hl_table("Normal", onepoint_colours_transparent))
    table.insert(my_colorscheme, get_hl_table("NonText", onepoint_colours_transparent))
    table.insert(my_colorscheme, get_hl_table("LineNr", onepoint_colours_transparent))
    table.insert(my_colorscheme, get_hl_table("Folded", onepoint_colours_transparent))
    table.insert(my_colorscheme, get_hl_table("EndOfBuffer", onepoint_colours_transparent))

    table.insert(my_colorscheme, get_hl_table("WinBar", onepoint_colours_transparent))
    table.insert(my_colorscheme, get_hl_table("WinBarNC", onepoint_colours_transparent))
    --table.insert(my_colorscheme, get_hl_table("SagaNormal", onepoint_colours_transparent))
    --table.insert(my_colorscheme, get_hl_table("SagaBorder", onepoint_colours_transparent))

    table.insert(my_colorscheme, get_hl_table("RegistersWindow", onepoint_colours_primary))
    table.insert(my_colorscheme, get_hl_table("Pmenu", opc_pmenu))
    table.insert(my_colorscheme, get_hl_table("PmenuSel", opc_pmenu_sel))
    table.insert(my_colorscheme, get_hl_table("PmenuSbar", opc_pmenu_sbar))
    table.insert(my_colorscheme, get_hl_table("PmenuThumb", opc_pmenu_thumb))

    table.insert(my_colorscheme, get_hl_table("NormalFloat", onepoint_colours_secondary))
    table.insert(my_colorscheme, get_hl_table("FloatBorder", onepoint_colours_secondary))
    table.insert(my_colorscheme, get_hl_table("FloatShadow", onepoint_colours_secondary))
    table.insert(my_colorscheme, get_hl_table("FloatShadowThrough", onepoint_colours_secondary))

    table.insert(my_colorscheme, get_hl_table("TermCursor", onepoint_colours_secondary))
    table.insert(my_colorscheme, get_hl_table("TermCursorNC", onepoint_colours_primary))

    table.insert(my_colorscheme, get_hl_table("Floaterm", onepoint_colours_term))
    table.insert(my_colorscheme, get_hl_table("FloatermBorder", onepoint_colours_term))
    table.insert(my_colorscheme, get_hl_table("FloatermNC", onepoint_colours_term_nc))

    table.insert(my_colorscheme, get_hl_table("DiffAdd", opc_diff_add))
    table.insert(my_colorscheme, get_hl_table("DiffDelete", opc_diff_delete))
    table.insert(my_colorscheme, get_hl_table("DiffChange", opc_diff_changed))
    table.insert(my_colorscheme, get_hl_table("DiffText", opc_diff_text))
  end

  utils.io.end_debug("colour.get_my_colorscheme")
  return my_colorscheme
end


M.setup = function()
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
      vim.opt.background = "dark"
    end,
  })

  vim.opt.termguicolors = true
  vim.o.termguicolors = true

  --  hl cursor line
  vim.opt.cursorline = true

  --  define colorscheme load function for lazyload
  local my_colorscheme = M.get_my_colorscheme()
  local myhl_augroup_id = vim.api.nvim_create_augroup("Myhl", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = myhl_augroup_id,
    callback = function() set_highlight_by_table(my_colorscheme) end,
  })

  utils.io.debug_echo("=== begin: default load ===")
  set_highlight_by_table(my_colorscheme)
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
