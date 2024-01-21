-- this init.vim is using utf-8
vim.opt.encoding = "utf-8"
vim.scriptencoding = "utf-8"

local utils = require("utils")

local fav_font_map = {
  Migu2M = "Migu 2M",
  Migu2MPL = "Migu 2M for Powerline",
  Cica = "Cica",
  Hack = "Hack",
  IntelOneMono = "IntoneMono Nerd Font Mono",
}

local currentFont = fav_font_map.IntelOneMono

-- Neovim GTK --
if vim.g.GtkGuiLoaded == 1 then
  --  vim.rpcnotify(1, "Gui", "Option", "Cmdline", 0)
  --  vim.rpcnotify(1, "Gui", "Option", "Popupmenu", 0)
  vim.rpcnotify(1, "Gui", "Option", "Tabline", 0)
  --  vim.rpcnotify(1, "Gui", "Option", "SetCursorBlink", 0)
  --  vim.rpcnotify(1, "Gui", "Font", "JetBrainsMono 10")
  --  vim.rpcnotify(1, "Gui", "Linespace", "2")
end

-- Migu 2M
-- https://osdn.jp/projects/mix-mplus-ipa/downloads/63545/migu-2m-20150712.zip/
--
-- Cica
-- https://github.com/miiton/Cica
--
-- intel one (with NERD font)
-- https://github.com/ryanoasis/nerd-fonts/issues/1238

local default_fontsize = 16
local fontsize = default_fontsize
local min_fontsize = 7

local function adjust_font_size(amount)
  fontsize = fontsize + amount
  vim.cmd("set guifont=" .. fav_font_map[currentFont] .. ":h" .. fontsize)
end
local function increment_font_size()
  adjust_font_size(1)
end
local function decrement_font_size()
  adjust_font_size(1)
end

local max_columns = 260

local function AutoAdjustFontSize()
  local diff = max_columns - utils.get_vim_columns()
  local unit = diff / 27
  -- 27ずつ
  local fontsize = fontsize + unit
  if fontsize < min_fontsize then
    fontsize = min_fontsize
  end
  vim.cmd("set guifont=" .. fav_font_map[currentFont] .. ":h" .. fontsize)
end

-- noremap <C-ScrollWheelUp> :call adjust_font_size(1)<CR>
-- noremap <C-ScrollWheelDown> :call adjust_font_size(-1)<CR>
-- inoremap <C-ScrollWheelUp> <Esc>:call adjust_font_size(1)<CR>a
-- inoremap <C-ScrollWheelDown> <Esc>:call adjust_font_size(-1)<CR>a
vim.keymap.set("n", "<C-ScrollWheelUp>", increment_font_size, { noremap = true })
vim.keymap.set("n", "<C-ScrollWheelDown>", decrement_font_size, { noremap = true })
vim.keymap.set("i", "<C-ScrollWheelUp>", increment_font_size, { noremap = true })
vim.keymap.set("i", "<C-ScrollWheelDown>", decrement_font_size, { noremap = true })

adjust_font_size(0)
