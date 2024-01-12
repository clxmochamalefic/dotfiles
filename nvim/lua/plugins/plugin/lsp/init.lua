-- ---------------------------------------------------------------------------
-- LSP PLUGINS
-- ---------------------------------------------------------------------------

local M = {}

local lsp = require('plugins.plugin.lsp.lsp-common')
local lss = require('plugins.plugin.lsp.lspsaga')
local nls = require('plugins.plugin.lsp.lsp-null-ls')
local nld = require('plugins.plugin.lsp.lsp-null-ls-depends')

local dap = require('plugins.plugin.lsp.dap')
local fmt = require('plugins.plugin.lsp.formatter')
local lnt = require('plugins.plugin.lsp.lint')

table.insert(M, lsp)
table.insert(M, lss)
table.insert(M, nls)
table.insert(M, nld)

table.insert(M, dap)
table.insert(M, fmt)
table.insert(M, lnt)

return M
