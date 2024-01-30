local M = {}

local g = vim.g
local o = vim.o
local fn = vim.fn
local opt = vim.opt
local keymap = vim.keymap

local wndutil = require("utils.sub.window")
local myutils = require("utils")

local default_border = "rounded"

local lsp_preferences = {
  float = {
    virtual_text = false,
    focus = false,
    focusable = false,
    silent = true,
    style = "minimal",
    border = default_border,
    max_width = 80,
    max_height = 20,
    -- close_events = {
    --   "CursorMoved",
    --   "CursorMovedI",
    --   "BufHidden",
    --   "InsertCharPre",
    --   "WinLeave",
    --   "InsertEnter",
    --   "InsertLeave"
    -- },
  },
  diagnostic = {
    virtual_text = { spacing = 4, prefix = "● " },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = default_border,
    },
    close_events = {
      "CursorMoved",
      "CursorMovedI",
      "BufHidden",
      "InsertCharPre",
      "WinLeave",
      "InsertEnter",
      "InsertLeave",
    },
  },
}

local diagnostic_signs = {
  { name = "DiagnosticSignError", text = "❌ " },
  { name = "DiagnosticSignWarn", text = " " },
  { name = "DiagnosticSignHint", text = "⚡ " },
  { name = "DiagnosticSignInfo", text = " " },
}

local function text_document_format(diag)
  return string.format("%s (%s: %s)", diag.message, diag.source, diag.code)
end

function M.setup()
  vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
  vim.opt.shortmess = "c"

  vim.diagnostic.config({
    float = {
      source = "if_many", -- Or "if_many"
      border = default_border,
    },
  })

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      format = text_document_format,
    },
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = default_border,
  })

  --vim.lsp.handlers["textDocument/implementation"] = require("lsputil.locations").implementation_handler

  for _, sign in ipairs(diagnostic_signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  vim.diagnostic.config(lsp_preferences.diagnostic)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, lsp_preferences.float)

  vim.api.nvim_create_autocmd("LspAttach", { callback = M.lsp_attach_callback })
end

function M.lsp_attach_callback(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", {})

    vim.opt.updatetime = 1000

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = wndutil.getBufnr(),
      group = group,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = wndutil.getBufnr(),
      group = group,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end
end

function M.on_attach(client, bufnr)
  local async = require("plenary.async")
  myutils.io.debug_echo("LSP started" .. client.name)
  async.run(function()
    vim.notify("LSP started: " .. client.name, vim.log.levels.INFO)
  end)

  -- auto hover popup for loaded filetypes
  if client.filetypes then
    for _, v in ipairs(client.filetypes) do
      vim.cmd([[autocmd CursorHold,CursorHoldI ]] .. v .. [[ lua vim.diagnostic.open_float(nil, {focus=false})]])
      vim.cmd([[autocmd CursorHold,CursorHoldI ]] .. v .. [[ silent lua vim.lsp.buf.hover()]])
    end
  end

  local bufopts = { silent = true, buffer = bufnr }
  keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  keymap.set("n", "<F2>", vim.lsp.buf.rename, bufopts)
  keymap.set("n", "<F3>", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

function M.get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
end

return M
