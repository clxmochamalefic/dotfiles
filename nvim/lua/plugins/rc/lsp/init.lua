-- ---------------------------------------------------------------------------
-- LSP PLUGINS
-- ---------------------------------------------------------------------------

local M = {}

local lsp = require("plugins.rc.lsp.lsp")
local lss = require("plugins.rc.lsp.lspsaga")
local nls = require("plugins.rc.lsp.lsp-null-ls")
local nld = require("plugins.rc.lsp.lsp-null-ls-depends")

local dap = require("plugins.rc.lsp.dap")
local fmt = require("plugins.rc.lsp.formatter")
local lnt = require("plugins.rc.lsp.linter")

table.insert(M, lsp)
table.insert(M, lss)
table.insert(M, nls)
-- TODO: lightbulb💡が出る不具合
table.insert(M, nld)

table.insert(M, dap)
table.insert(M, fmt)
table.insert(M, lnt)

return M
