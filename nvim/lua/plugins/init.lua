local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local loop = vim.loop
local keymap = vim.keymap

local plugins = {}

plugins.setup = function()
  local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not loop.fs_stat(lazypath) then
    fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  opt.rtp:prepend(lazypath)

  require('lazy').setup("plugins.plugin")
end

return plugins
