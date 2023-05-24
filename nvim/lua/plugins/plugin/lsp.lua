-- LSP ------------------------------
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
--        general settings
--        vim.diagnostic.config({
--          float = {
--            source = "always", -- Or "if_many"
--          },
--        })
--        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--          vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true }
--        )
--        You will likely want to reduce updatetime which affects CursorHold
--        note: this setting is global and should be set only once
--        vim.o.updatetime = 100
--        vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]


        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          virtual_text = false,
          focus = false,
          border = "rounded",
        })

--        -- You will likely want to reduce updatetime which affects CursorHold
--        -- note: this setting is global and should be set only once
        vim.o.updatetime = 500
--          vim.cmd [[autocmd CursorMoved,CursorMovedI,CursorHold,CursorHoldI * silent lua vim.lsp.buf.hover()]]
--          vim.cmd [[autocmd CursorHold,CursorHoldI * silent lua vim.lsp.buf.hover()]]
--          vim.cmd [[autocmd LspAttach * silent lua vim.lsp.buf.hover()]]
--          vim.cmd [[autocmd BufReadPost * silent lua vim.lsp.buf.hover()]]

        local function is_active_lsp_on_current_buffer(bufNumber)
            local isLoadLsp = false;
            vim.lsp.for_each_buffer_client(bufNumber, function(client, client_id, bufnr)
                if client.name ~= "null-ls" then
                    isLoadLsp = true
                end
            end)
          
            return isLoadLsp
        end

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
        mason_lspconfig.setup({ ensure_installed = servers })
        mason_lspconfig.setup_handlers({
          function(server_name)
            local opts = {}
            --      opts.on_attach = function(_, bufnr)
            --        local bufopts = { silent = true, buffer = bufnr }
            --
            --        -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            --        -- vim.keymap.set('n', 'gtD', vim.lsp.buf.type_definition, bufopts)
            --        -- vim.keymap.set('n', 'grf', vim.lsp.buf.references, bufopts)
            --        -- vim.keymap.set('n', '<space>p', vim.lsp.buf.format, bufopts)
            --      end
            opts.capabilities = capabilities

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
      config = require "plugins.preference.lsp.mason.config",
    },
    -- neodev.nvim ------------------------------
    {
      lazy = true,
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
      lazy = true,
      'jay-babu/mason-null-ls.nvim',
      dependencies = {
        'jose-elias-alvarez/null-ls.nvim',
      },
      config = function()
        require('mason-null-ls').setup({
          ensure_installed = nil,
          automatic_installation = {
            exclude = {
              'textlint',
            },
          },
          automatic_setup = false,
        })
      end
    },
    {
      lazy = true,
      'jose-elias-alvarez/null-ls.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
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

