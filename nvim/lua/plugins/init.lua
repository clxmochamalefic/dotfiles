local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local loop = vim.loop
local keymap = vim.keymap

local opts = {
  defaults = {
    lazy = true,
  },
  performance = {
    cache = {
      enabled = true,
    },
  },
}

local M = {}

M.setup = function()
  local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not loop.fs_stat(lazypath) then
    fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=main",
      lazypath,
    })
  end
  opt.rtp:prepend(lazypath)

  --api.nvim_create_autocmd("VimEnter", {
  --  callback = function(_)
  --    --api.nvim_set_keymap("n", "<leader>l", ":Lazy<CR>", { silent = true, desc = "lazy" })
  --  end,
  --})

  --require("lazy").setup("plugins.rc", opts)
  require("lazy").setup("plugins.rc")
end

return M
