local utils = require('utils')

local g = vim.g
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

local M = {}

local setupper = {}

function M.setup()
  
  if utils.env.is_wsl_linux() then
    -- wsl only
    setupper = require("preferences.config.path.linux")
  elseif utils.env.is_pure_linux() then
    -- host linux
    setupper = require("preferences.config.path.linux")

  elseif utils.env.is_windows() then
    -- host windows
    setupper = require("preferences.config.path.win")

  elseif utils.env.is_mac() then
    -- host macOS
    setupper = require("preferences.config.path.mac")
  else
  end
  setupper.setup()
end

return M

