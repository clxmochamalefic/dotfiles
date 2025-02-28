-- ---------------------------------------------------------------------------
-- LSP SERVER CONFIG
-- ---------------------------------------------------------------------------
--
local tblUtil = require("utils.table")

local path = [[plugins.rc.lsp.config.server.]]

local M = {
  lang = {
    jdtls = require(path .. "jdtls"),
    denols = require(path .. "denols"),
    -- denols = nil,
    ts_ls = require(path .."tsserver"),
    prismals = nil,
    omnisharp = nil,
    dockerls = nil,
    eslint = nil,
    jsonls = nil,
    intelephense = nil,
    powershell_es = nil,
    sqlls = nil,
    lemminx = nil,
    yamlls = nil,
    html = nil,
    cssls = nil,
    marksman = nil,
    clangd = nil,
    vimls = nil,
    lua_ls = require(path .. "lua_ls"),
    prettierd = require(path .. "prettierd"),
    rust = require(path .. "rust_analyzer"),
  },
  no_mason = {
    "prettierd",
  },
  servers = {},
}

M.setup = function()
  for k, v in pairs(M.lang) do
    if v ~= nil and tblUtil.is_key_exists(M.servers, k) then
      table.insert(M.servers, k)
    end
  end
end

M.setupToServerByName = function(lspconfig, name, opts)
  if M.lang[name] ~= nil then
    ---@diagnostic disable-next-line: undefined-field
    M.lang[name].setup(lspconfig, lspconfig[name], opts)
  else
    lspconfig[name].setup(opts)
  end
end

M.setupToServerForNoMasons = function(lspconfig, opts)
  for _, v in ipairs(M.no_mason) do
    M.setupToServerByName(lspconfig, v, opts)
  end
end

return M
