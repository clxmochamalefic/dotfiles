local utils = require('utils')

local g = vim.g
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

local M = {}

local setupper = {}

function M.setup()
  if fn["has"]('win32') == 1 and fn["has"]('wsl') == 1 then
    -- wsl only
    setupper = require("preferences.individual.path.linux")
  elseif vim.fn.has('wsl') or vim.fn.has('linux') then
    -- host linux
    setupper = require("preferences.individual.path.linux")

  elseif vim.fn.has('win32') then
    -- host windows
    setupper = require("preferences.individual.path.win")

  elseif vim.fn.has('mac') or vim.fn.has('unix') then
    -- host macOS
    setupper = require("preferences.individual.path.mac")
  else
  end
  setupper.setup()
end

return M

