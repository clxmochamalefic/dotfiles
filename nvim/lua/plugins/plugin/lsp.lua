-- LSP ------------------------------

local util = require 'vim.lsp.util'
local myutils = require 'utils'

local g = vim.g
local o = vim.o
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap
local diagnostic = vim.diagnostic

local lsp = vim.lsp

local border = "rounded"

local function on_cursor_hold()
  if lsp.buf.server_ready() then
    diagnostic.open_float()
  end
end

local diagnostic_hover_augroup_name = "lspconfig-diagnostic"

local function enable_diagnostics_hover()
  api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
  api.nvim_create_autocmd({ "CursorHold" }, { group = diagnostic_hover_augroup_name, callback = on_cursor_hold })
end

local function disable_diagnostics_hover()
  api.nvim_clear_autocmds({ group = diagnostic_hover_augroup_name })
end

local function on_hover()
  disable_diagnostics_hover()

  lsp.buf.hover()

  api.nvim_create_augroup("lspconfig-enable-diagnostics-hover", { clear = true })
  -- ウィンドウの切り替えなどのイベントが絡んでくるとおかしくなるかもしれない
  api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { group = "lspconfig-enable-diagnostics-hover", callback = function()
    api.nvim_clear_autocmds({ group = "lspconfig-enable-diagnostics-hover" })
    enable_diagnostics_hover()
  end })
end

local formatting_callback = function(client, bufnr)
  keymap.set('n', '<leader>f', function()
    local params = util.make_formatting_params({})
    client.request('textDocument/formatting', params, nil, bufnr) 
  end, { buffer = bufnr })
end

return {
  {
      lazy = true,
      'neovim/nvim-lspconfig',
      cmd = { "LspInstall", "LspUninstall" },
      event = { 'InsertEnter' },
      dependencies = {
        'williamboman/mason-lspconfig.nvim',
      },
      config = function()
        -- general settings
        diagnostic.config({
          float = {
            source = "always", -- Or "if_many"
          },
        })
        lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
          lsp.diagnostic.on_publish_diagnostics, { virtual_text = true }
        )
        lsp.handlers["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover, {
            border = border,
            virtual_text = false,
            focus = false,
        })
        lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
          border = border,
        })
--        You will likely want to reduce updatetime which affects CursorHold
--        note: this setting is global and should be set only once
        o.updatetime = 1000
--        api.nvim_set_option('updatetime', 1000)

        vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

        --enable_diagnostics_hover()

--        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--          virtual_text = false,
--          focus = false,
--          border = "rounded",
--        })

--        -- You will likely want to reduce updatetime which affects CursorHold
--        -- note: this setting is global and should be set only once
--        vim.o.updatetime = 500
--          vim.cmd [[autocmd CursorMoved,CursorMovedI,CursorHold,CursorHoldI * silent lua vim.lsp.buf.hover()]]
--          vim.cmd [[autocmd CursorHold,CursorHoldI * silent lua vim.lsp.buf.hover()]]
--          vim.cmd [[autocmd LspAttach * silent lua vim.lsp.buf.hover()]]
--          vim.cmd [[autocmd BufReadPost * silent lua vim.lsp.buf.hover()]]

--        local function is_active_lsp_on_current_buffer(bufNumber)
--            local isLoadLsp = false;
--            vim.lsp.for_each_buffer_client(bufNumber, function(client, client_id, bufnr)
--                if client.name ~= "null-ls" then
--                    isLoadLsp = true
--                end
--            end)
--
--            return isLoadLsp
--        end

--        vim.api.nvim_create_autocmd("LspAttach", {
--          callback = function(args)
--          -- vim.cmd [[autocmd CursorHold,CursorHoldI * silent lua vim.lsp.buf.hover()]]
--            vim.cmd [[autocmd CursorHold,CursorHoldI * silent lua vim.lsp.buf.hover()]]
--        
--          -- local bufnr = args.buf
--          -- local client = vim.lsp.get_client_by_id(args.data.client_id)
--          -- if client.server_capabilities.completionProvider then
--          --   vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
--          -- end
--          -- if client.server_capabilities.definitionProvider then
--          --   vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
--          -- end
--        end,
--})        

        -- nvim-ufo ------------------------------

        -- local ufo = require('ufo')
        -- ufo.setup()
      end
    },
    {
      lazy = true,
      'williamboman/mason-lspconfig.nvim',
      event = { 'InsertEnter' },
      dependencies = {
        'vim-denops/denops.vim',
        'mfussenegger/nvim-dap',
      },
      opts = function(_, opts)
        if not opts.handlers then
          opts.handlers = {}
        end
        opts.handlers[1] = function(server) require("utils.lsp").setup(server) end
      end,
      config = function()
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

        --  require("mason-lspconfig").setup(opts)
        local capabilities = lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
        }

        local lspconfig = require "lspconfig"
        local mason_lspconfig = require "mason-lspconfig"
        local on_attach = function(client, bufnr)
          myutils.echo("LSP started")

          local bufopts = { silent = true, buffer = bufnr }
          keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
          keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
          keymap.set('n', 'gx', vim.lsp.buf.type_definition, bufopts)
          keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
          keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          keymap.set('n', 'gX', vim.lsp.buf.references, bufopts)
          keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
          keymap.set('n', '<F3>', function() vim.lsp.buf.format { async = true } end, bufopts)

          --              if client.name ~= 'ccls' then
          --                formatting_callback(client, bufnr)
          --              end
          --              common_on_attach(client, bufnr)
        end

        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }
        mason_lspconfig.setup({ ensure_installed = servers })
        mason_lspconfig.setup_handlers({
          function(server_name)
            lspconfig[server_name].setup(opts)
          end
        })
      end,
    },
    {
      lazy = true,
      'williamboman/mason.nvim',
      dependencies = {
        'vim-denops/denops.vim',
        'mfussenegger/nvim-dap',
      },
      cmd = {
        "Mason",
        "MasonInstall",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonLog",
      },
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_uninstalled = "✗",
            package_pending = "⟳",
          },
        },
      },
      build = ":MasonUpdate",
      config = function(_, opts)
        require("mason").setup(opts)
      end,
    },
    -- neodev.nvim ------------------------------
    {
      'folke/neodev.nvim',
      config = function()
          require("neodev").setup({})
      end
    },
    {
      lazy = true,
      'mfussenegger/nvim-dap',
    },
    {
      'jay-babu/mason-null-ls.nvim',
      dependencies = {
        'jose-elias-alvarez/null-ls.nvim',
      },
      config = function()
        require('mason-null-ls').setup({
          automatic_setup = true,
          ensure_installed = nil,
          automatic_installation = {
            exclude = {
              'textlint',
            },
          },
          handlers = {
            function(source_name, methods)
              require("mason-null-ls.automatic_setup")(source_name, methods)
            end,
          },
        })
      end
    },
    {
      'jose-elias-alvarez/null-ls.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
      build = "pip install editorconfig-checker",
      config = function()
        local null_ls = require("null-ls")
        null_ls.setup(
        {
          on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
              myutils.echo("Setting up null-ls formatting")
              vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                  vim.lsp.buf.format({ bufnr = bufnr })
                end,
              })
            end
          end,
          sources = {
            null_ls.builtins.code_actions.eslint_d,
            null_ls.builtins.code_actions.proselint,
            null_ls.builtins.code_actions.shellcheck,
            null_ls.builtins.code_actions.statix,
            null_ls.builtins.completion.spell,
            null_ls.builtins.diagnostics.editorconfig_checker.with(
            {
              command = "editorconfig-checker"
            }
            ),
            null_ls.builtins.diagnostics.actionlint,
            null_ls.builtins.diagnostics.commitlint,
            null_ls.builtins.diagnostics.curlylint,
            null_ls.builtins.diagnostics.deadnix,
            null_ls.builtins.diagnostics.djlint,
            null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.diagnostics.fish,
            null_ls.builtins.diagnostics.gitlint,
            null_ls.builtins.diagnostics.hadolint,
            null_ls.builtins.diagnostics.proselint,
            null_ls.builtins.diagnostics.pylama,
            null_ls.builtins.diagnostics.shellcheck,
            null_ls.builtins.diagnostics.staticcheck,
            null_ls.builtins.diagnostics.statix,
            null_ls.builtins.diagnostics.vale,
            null_ls.builtins.diagnostics.write_good,
            null_ls.builtins.diagnostics.tidy,
            null_ls.builtins.formatting.alejandra,
            null_ls.builtins.formatting.beautysh,
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.cbfmt,
            null_ls.builtins.formatting.clang_format,
            null_ls.builtins.formatting.djlint,
            null_ls.builtins.formatting.eslint_d,
            null_ls.builtins.formatting.fish_indent,
            null_ls.builtins.formatting.goimports.with({
              condition = function(utils)
                -- Try to detect if we are in a tailscale repo
                return utils.root_has_file({ "go.toolchain.rev" })
              end,
            }),
            null_ls.builtins.formatting.golines.with({
              condition = function(utils)
                return not utils.root_has_file({ "go.toolchain.rev" })
              end,
            }),
            null_ls.builtins.formatting.isort,
            null_ls.builtins.formatting.jq,
            null_ls.builtins.formatting.tidy,
            null_ls.builtins.formatting.prettierd,
            null_ls.builtins.formatting.shellharden,
            null_ls.builtins.formatting.swiftformat,
            -- null_ls.builtins.formatting.terraform_fmt, -- Covered by LSP?
            null_ls.builtins.formatting.trim_newlines,
            null_ls.builtins.formatting.trim_whitespace,
            null_ls.builtins.formatting.packer,
            null_ls.builtins.hover.dictionary
          }
        }
        )
      end,
      --config = function(_, _)
      --  -- https://github.com/jose-elias-alvarez/null-ls.nvim
      --  local null_ls = require("null-ls")

      --  local code_actions = null_ls.builtins.code_actions
      --  local completion = null_ls.builtins.completion
      --  local diagnostics = null_ls.builtins.diagnostics
      --  local formatting = null_ls.builtins.formatting
      --  local hover = null_ls.builtins.hover

      --  local sources = {
      --    code_actions.gitsigns,
      --    completion.vsnip,
      --    formatting.stylua,
      --    formatting.taplo,
      --    diagnostics.textlint.with({
      --      filetypes = { 'markdown' },
      --      prefer_local = 'node_modules/.bin',
      --    }),
      --    formatting.textlint.with({
      --      filetypes = { 'markdown' },
      --      prefer_local = 'node_modules/.bin',
      --    }),
      --    diagnostics.textlint.credo,
      --  }

      --  null_ls.setup({
      --    border = 'single',
      --    diagnostics_format = '#{m} (#{s}: #{c})',
      --    sources = sources,
      --  })
      --end
    },
    {
      lazy = true,
      'nvim-lua/plenary.nvim',
      build = 'npm install -g textlint textlint-rule-prh textlint-rule-preset-jtf-style textlint-rule-preset-ja-technical-writing textlint-rule-terminology textlint-rule-preset-ja-spacing',
    },
    {
      lazy = true,
      'kevinhwang91/nvim-ufo',
      dependencies = {
        'kevinhwang91/promise-async'
      }
    },
    {
      lazy = true,
      'kevinhwang91/promise-async'
    },
--        {
--          lazy = true,
--          'nvimdev/lspsaga.nvim',
--          dependencies = {
--            {
--              'nvim-treesitter/nvim-treesitter',
--              event = 'BufRead',
--              cmd = { 'TSUpdate', 'TSInstall', 'TSInstallFromGrammar', 'TSInstallInfo', 'TSModuleInfo', 'TSConfigInfo' },
--              build = 'vim.cmd("TSInstallFromGrammar")',
--            },
--            'nvim-tree/nvim-web-devicons',
--            event = { 'LspAttach' }
--          },
--        },
--        {
--          lazy = true,
--          'nvim-treesitter/nvim-treesitter',
--        },
}

