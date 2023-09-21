local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local utils = require("utils")
local km_opts = require("const.keymap")

local M = {
  ui = {},
}

function M.setup()
  local filer = require("ui.filer")
  local ff    = require("ui.ff")
  local lsp   = require("ui.lsp_actions")

  local ui = {
    ff    = ff.setup(),
    lsp   = lsp.setup(),
    filer = filer.setup(),
  }

  M.ui = ui
end

return M

