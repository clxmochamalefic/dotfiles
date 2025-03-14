---@diagnostic disable: undefined-global
-- this init.vim is using utf-8
vim.opt.encoding = "utf-8"
vim.scriptencoding = "utf-8"

local utils = require("utils")
local fav_font_map = require("const.font")

local neoviderc = require("preferences.gui.rc.neovide")

local default_fontsize = 13

local M = {
  -- common
  c = {
    font = {
      currentFont = fav_font_map.IntelOneMono,
      fontsize = default_fontsize,
      min_fontsize = 7,
      max_columns = 260,
    },
  },
  -- resources
  rc = {
    neovide = neoviderc,
  },
}

local function adjust_font_size(amount)
  M.c.font.fontsize = M.c.font.fontsize + amount
  vim.cmd("set guifont=" .. M.c.font.currentFont .. ":h" .. M.c.font.fontsize)
end
local function increment_font_size()
  adjust_font_size(1)
end
local function decrement_font_size()
  adjust_font_size(-1)
end

local function AutoAdjustFontSize()
  local diff = M.c.font.max_columns - utils.get_vim_columns()
  local unit = diff / 27
  -- 27ずつ
  local fontsize = M.c.font.fontsize + unit
  if fontsize < M.c.font.min_fontsize then
    fontsize = M.c.font.min_fontsize
  end
  vim.cmd("set guifont=" .. fav_font_map[currentFont] .. ":h" .. fontsize)
end

function M:font()
  adjust_font_size(0)
end

function M:map()
  vim.keymap.set("n", "<C-ScrollWheelUp>", increment_font_size, { noremap = true })
  vim.keymap.set("n", "<C-ScrollWheelDown>", decrement_font_size, { noremap = true })
  vim.keymap.set("i", "<C-ScrollWheelUp>", increment_font_size, { noremap = true })
  vim.keymap.set("i", "<C-ScrollWheelDown>", decrement_font_size, { noremap = true })

  vim.keymap.set({ "n", "i", "v", "x", "t" }, "<S-Insert>", "<C-R>+", { noremap = true })
end

function M:setup()
  -- Neovim GTK --
  if vim.g.GtkGuiLoaded == 1 then
    --  vim.rpcnotify(1, "Gui", "Option", "Cmdline", 0)
    --  vim.rpcnotify(1, "Gui", "Option", "Popupmenu", 0)
    vim.rpcnotify(1, "Gui", "Option", "Tabline", 0)
    --  vim.rpcnotify(1, "Gui", "Option", "SetCursorBlink", 0)
    --  vim.rpcnotify(1, "Gui", "Font", "JetBrainsMono 10")
    --  vim.rpcnotify(1, "Gui", "Linespace", "2")
  end
  M:font()
  M:map()

  if neoviderc:can_setup() then
    neoviderc:setup()
  end
end

return M
