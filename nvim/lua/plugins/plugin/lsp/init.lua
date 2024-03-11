-- ---------------------------------------------------------------------------
-- LSP PLUGINS
-- ---------------------------------------------------------------------------

local M = {}

local lsp = require("plugins.plugin.lsp.lsp")
local lss = require("plugins.plugin.lsp.lspsaga")
local nls = require("plugins.plugin.lsp.lsp-null-ls")
local nld = require("plugins.plugin.lsp.lsp-null-ls-depends")

local dap = require("plugins.plugin.lsp.dap")
local fmt = require("plugins.plugin.lsp.formatter")
local lnt = require("plugins.plugin.lsp.linter")

table.insert(M, lsp)
table.insert(M, lss)
table.insert(M, nls)
-- TODO: lightbulb💡が出る不具合
--table.insert(M, nld)

table.insert(M, dap)
table.insert(M, fmt)
table.insert(M, lnt)

return M
