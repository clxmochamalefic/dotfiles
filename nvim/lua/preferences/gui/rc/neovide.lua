---@diagnostic disable: undefined-global

local M = {}

function M:can_setup()
  return vim.g.neovide
end

function M:setup()
  if self:can_setup() then
    vim.print("in neovide")
    return
  end

  vim.print("normal neovim")
end

return M
