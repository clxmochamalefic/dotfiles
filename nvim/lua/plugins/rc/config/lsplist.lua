local utils = require("utils")

local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local km_opts = require("const.keymap")

local M = {}

function M.lsplist()
  local lspconfig = require("lspconfig")
  local lcutil = lspconfig.util
  local availables = lcutil.available_servers()
  local availables = lcutil.get_managed_clients()
end

return M
