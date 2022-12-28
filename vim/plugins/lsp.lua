local saga = require "lspsaga"
saga.init_lsp_saga()

vim.api.nvim_set_keymap('n', '[lsp]', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>l', '[lsp]', { noremap = false })
vim.api.nvim_set_keymap('n', '[lsp]a', ':Lspsaga code_action<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]c', ':lua vim.lsp.buf.declaration()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]dp', ':Lspsaga peek_definition<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]dd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]f', ':lua vim.lsp.buf.formatting{timeout_ms = 5000, async = true}<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]h', ':Lspsaga hover_doc<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]i', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]x', ':lua vim.lsp.buf.references()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]r', ':Lspsaga rename<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]t', ':lua vim.lsp.buf.type_definition()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]e', ':Lspsaga show_line_diagnostics<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]n', ':Lspsaga diagnostic_jump_next<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]p', ':Lspsaga diagnostic_jump_prev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]s', ':lua vim.lsp.buf.signature_help()<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true })

-- general settings
vim.diagnostic.config({
  float = {
    source = "always", -- Or "if_many"
  },
})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 100
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

function PrintDiagnostics(opts, bufnr, line_nr)
  opts = opts or {}

  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
  local line_diagnostics = vim.diagnostic.get(bufnr, { lnum = line_nr })
  if vim.tbl_isempty(line_diagnostics) then return end

  for _, diagnostic in ipairs(line_diagnostics) do
    local output = string.format("[%s] %s [%s]",
      diagnostic.source or "",
      diagnostic.message or "",
      vim.diagnostic.severity[diagnostic.severity] or ""
    )
    if #output > 140 then
      output = string.sub(output, 0, 140) .. '...'
    end
    vim.api.nvim_echo({ { output } }, false, {})
    break
  end
end

vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]

local mason = require "mason"
mason.setup {}

local servers = {
  "tsserver",
  "denols",
  "prismals",
  "omnisharp",
  "dockerls",
  "eslint",
  "jsonls",
  "intelephense",
  "powershell_es",
  "sqlls",
  "lemminx",
  "yamlls",
  "html",
  "cssls",
  "marksman",
  "clangd",
  "vimls",
  "sumneko_lua",
}

local lspconfig = require "lspconfig"

local mason_lspconfig = require "mason-lspconfig"
mason_lspconfig.setup({
  ensure_installed = servers
})
mason_lspconfig.setup_handlers({
  function(server_name)
    local opts = {}
    opts.on_attach = function(_, bufnr)
      local bufopts = { silent = true, buffer = bufnr }

      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', 'gtD', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', 'grf', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<space>p', vim.lsp.buf.format, bufopts)
    end

    lspconfig[server_name].setup(opts)
  end
})
