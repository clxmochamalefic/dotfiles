local utils = require('utils')

local g = vim.g
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

local M = {}

local setupper = {}

function M.setup()
  if vim.fn.has('wsl') or vim.fn.has('linux') then
    setupper = require("preferences.individual.path.linux")
  elseif vim.fn.has('win32') then
    setupper = require("preferences.individual.path.win")
  elseif vim.fn.has('mac') or vim.fn.has('unix') then
    setupper = require("preferences.individual.path.mac")
  else
  end
  setupper.setup()
end

return M

