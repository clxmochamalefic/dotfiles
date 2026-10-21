---@diagnostic disable: undefined-global

--- ref: https://namileriblog.com/mac/neovide_settings/

local env = require("utils.env")

local M = {}

function M:can_setup()
  return env.is_neovide()
end

function M:setup()
  if not self:can_setup() then
    vim.print("normal neovim")
    return
  end
  vim.print("in neovide")

  -- デフォルトリフレッシュレート
  vim.g.neovide_refresh_rate = 60
  -- フォーカスされていないときのリフレッシュ レート
  vim.g.neovide_refresh_rate_idle = 1

  -- transparency
  vim.g.neovide_opacity = 0.9
  -- alphablended window border
  vim.g.neovide_show_border = true

  -- スケール：拡大率
  vim.g.neovide_scale_factor = 1.0
  -- パディング
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0


  -- 挿入モードで Shift + Insert を使ってペースト
  vim.keymap.set('i', '<S-Insert>', '<C-R>+', { noremap = true, silent = true })

  -- ノーマルモードで Shift + Insert を使ってペースト
  vim.keymap.set('n', '<S-Insert>', '"+P', { noremap = true, silent = true })

  -- Exモードで Shift + Insert を使ってペースト
  vim.keymap.set('c', '<S-Insert>', '<C-R>+', { noremap = true, silent = false })

  -- ターミナルモード等で使う場合
  vim.keymap.set('t', '<S-Insert>', '<C-W>"+', { noremap = true, silent = true })
end

return M

