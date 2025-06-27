---@diagnostic disable: undefined-global

--- ref: https://namileriblog.com/mac/neovide_settings/

local env = require("utils.sub.env")

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
end

return M

