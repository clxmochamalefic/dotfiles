-- null-ls.nvim
-- https://github.com/jose-elias-alvarez/null-ls.nvim
local null_ls = require("null-ls")

local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
--local hover = null_ls.builtins.hover

local sources = {
  code_actions.gitsigns,
  completion.vsnip,
  formatting.stylua,
  formatting.taplo,
  diagnostics.textlint.with({
    filetypes = { 'markdown' },
    prefer_local = 'node_modules/.bin',
  }),
  formatting.textlint.with({
    filetypes = { 'markdown' },
    prefer_local = 'node_modules/.bin',
  }),
}

null_ls.setup({
  border = 'single',
  diagnostics_format = '#{m} (#{s}: #{c})',
  sources = sources,
})
-- null_ls.setup({
--   sources = {
--     null_ls.builtins.formatting.stylua,
--     null_ls.builtins.diagnostics.eslint,
--     null_ls.builtins.completion.spell,
--   },
--   diagnostics_format = "#{m} (#{s}: #{c})",
-- })

--
-- general settings
-- vim.diagnostic.config({
--   float = {
--     source = "always", -- Or "if_many"
--   },
-- })
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true }
-- )
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
-- vim.o.updatetime = 100
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    virtual_text = false,
    focus = false,
    border = "rounded",
  }
)

---- You will likely want to reduce updatetime which affects CursorHold
---- note: this setting is global and should be set only once
vim.o.updatetime = 100
-- vim.cmd [[autocmd CursorMoved,CursorMovedI,CursorHold,CursorHoldI * silent lua vim.lsp.buf.hover()]]
-- vim.cmd [[autocmd CursorHold,CursorHoldI * silent lua vim.lsp.buf.hover()]]
-- vim.cmd [[autocmd LspAttach * silent lua vim.lsp.buf.hover()]]
-- vim.cmd [[autocmd BufReadPost * silent lua vim.lsp.buf.hover()]]

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.cmd [[autocmd CursorHold,CursorHoldI * silent lua vim.lsp.buf.hover()]]
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end
  end,
})

local mason = require "mason"
mason.setup({
  ui = {
    check_outdated_packages_on_open = true,
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    },
    keymaps = {
      -- Keymap to expand a package
      toggle_package_expand = "<CR>",
      -- Keymap to install the package under the current cursor position
      install_package = "i",
      -- Keymap to reinstall/update the package under the current cursor position
      update_package = "u",
      -- Keymap to check for new version for the package under the current cursor position
      check_package_version = "c",
      -- Keymap to update all installed packages
      update_all_packages = "U",
      -- Keymap to check which installed packages are outdated
      check_outdated_packages = "C",
      -- Keymap to uninstall a package
      uninstall_package = "X",
      -- Keymap to cancel a package installation
      cancel_installation = "<C-c>",
      -- Keymap to apply language filter
      apply_language_filter = "<C-f>",
    },
  },
})

local servers = {
  "tsserver",
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

