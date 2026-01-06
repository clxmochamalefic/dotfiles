---@diagnostic disable: undefined-global
-- ---------------------------------------------------------------------------
-- LSP COMMON PLUGINS
-- ---------------------------------------------------------------------------

local myutils = require("utils")
local mymason = require("plugins.rc.lsp.mason")

local border = "rounded"

local icons = {
  package_installed = "✓",
  package_uninstalled = "✗",
  package_pending = "⟳",
}

function call_my_mason()
  require("plugins.rc.lsp.mason")
end

function openDiagnostics()
  vim.diagnostic.open_float(nil, {
    focus = false,
    border = border,
  })
end

function openHover()
  vim.lsp.buf.hover({
    focus = false,
    border = border,
  })
end

local function text_document_format(diag)
  -- return string.format("%s (%s: %s)", diag.message, diag.source, diag.code)
  return string.format("💡(%s)", diag.source)
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim",           opts = {} },
      { "mason-org/mason-lspconfig.nvim", opts = {} },
      "vim-denops/denops.vim",
      "nvim-lua/plenary.nvim",
      "rcarriga/nvim-notify",
      "mfussenegger/nvim-dap",
    },
    lazy = true,
    --lazy = false,
    event = {
      "FileReadPre",
      "BufReadPre",
      "InsertChange",
    },
    cmd = {
      "LspStart",
      "LspRestart",
      "LspStop",
      "LspInstall",
      "LspUninstall",
      "LspInfo",

      "Mason",
    },
    config = function()
      -- general settings
      vim.diagnostic.config({
        float = {
          source = "if_many", -- Or "if_many"
          border = border,
        },
      })
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- virtual_text = false,
        virtual_text = {
          format = text_document_format,
        },
      })
      vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
        local diag = vim.lsp.diagnostic.get_line_diagnostics()
        config = config or {}
        config.focus_id = ctx.method
        if not (result and result.contents) then
          -- vim.notify("No information available: result")
          return
        end
        -- myutils.io.echo_table("result.contents", result.contents)

        local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
        markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)

        local nv = myutils.env.get_nvim_version()


        config.border = border
        config.focus = false
        config.silent = true

        local cid = ctx.client_id
        local client = vim.lsp.get_client_by_id(cid)
        config.title = "hover: " .. client.name

        return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
      end

      local signatureHelpStack = {}
      vim.lsp.handlers["textDocument/signatureHelp"] = function(_, result, ctx, config)
        local uri = result.uri
        local bufnr = vim.uri_to_bufnr(uri)
        if not bufnr then
          return
        end

        local diagnostics = result.diagnostics
        vim.lsp.diagnostic.set(diagnostics, bufnr, ctx.client_id)
        if not vim.api.nvim_buf_is_loaded(bufnr) then
          return
        end

        local cid = ctx.client_id
        local line = vim.fn["line"](".")
        local key = bufnr .. "_" .. cid .. "_" .. "l" .. line
        if myutils.table.is_key_exists(signatureHelpStack, key) then
          vim.notify("suppress lsp diag: " .. key)
          return
        end
        signatureHelpStack[key] = result

        config.border = border
        config.focus = false
        config.silent = true

        local cid = ctx.client_id
        local client = vim.lsp.get_client_by_id(cid)
        config.title = "sigHelp: " .. client.name

        vim.lsp.diagnostic.show(diagnostics, bufnr, ctx.client_id, config)
      end

      --        You will likely want to reduce updatetime which affects CursorHold
      --        note: this setting is global and should be set only once
      vim.api.nvim_set_option("updatetime", 1000)

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local lspconfig = require("lspconfig")
      mymason.setup()

      -- TODO: 👇 ここ外だししたいが、 `lspconfig.util.root_pattern` に依存しているので考えるのがめんどい
      local util = require 'lspconfig.util'
      local server_preferences = {
        ["astro"] = {},
        ["cssls"] = {},
        ["css_variables"] = {},
        ["cssmodules_ls"] = {},
        ["denols"] = {
          filetypes = {
            'typescript',
          },
          root_dir = util.root_pattern("deno.json", "deno.jsonc", "deps.ts", "import_map.json"),
          single_file_support = true,
          settings = {
            deno = {
              enable = true,
              lint = true,
              unstable = true,
              suggest = {
                imports = {
                  hosts = {
                    ["https://deno.land"] = true,
                    ["https://cdn.nest.land"] = true,
                    ["https://crux.land"] = true,
                  },
                },
              }
            },
          },
          ["docker_compose_language_service"] = {},
          ["dockerls"] = {},
          ["html"] = {},
          ["intelephense"] = {},
          ["luals"] = {
            cmd = { 'lua-language-server' },
            filetypes = { 'lua' },
            root_markers = {
              { '.luarc.json', '.luarc.jsonc' },
              '.git',
            },
            Lua = {
              hint = { enable = true, },
              completion = { callSnippet = "Replace", },
              runtime = {
                version = 'LuaJIT',
              },
            },
          },
          ["marksman"] = {},
          ["rust_analyzer"] = {
            root_dir = util.root_pattern('Cargo.toml'),
            filetypes = { "rust" },
            cmd = { "ra-multiplex" },
            settings = {
              ["rust_analyzer"] = {
                lru = {
                  Capacity = 64,
                },
                assist = {
                  importGranularity = "module",
                  importPrefix = "by_crate",
                },
                procMacro = {
                  enable = true,
                },
                checkOnSave = {
                  command = "clippy",
                  allTargets = false,
                },
                cargo = {
                  loadOutDirsFromCheck = true,
                  -- allFeatures = true,
                },
                completion = {
                  autoimport = {
                    enable = true,
                  },
                },
                diagnostics = {
                  disabled = {
                    "unresolved-macro-call",
                  },
                },
              },
            },
          },
          ["svelte"] = {},
          ["tailwindcss"] = {},
          ["ts_ls"] = {
            root_dir = util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json'),
            single_file_support = true,
            settings = {
              ["ts_ls"] = {
                filetypes = {
                  'javascript',
                  'javascriptreact',
                  'javascript.jsx',
                  'typescript',
                  'typescriptreact',
                  'typescript.tsx',
                },
              },
              docs = {
                description = [[https://github.com/typescript-language-server/typescript-language-server]],
              },
            },
          },
          ["vtsls"] = {},
          ["vue_ls"] = {},
        }
      }
      -- TODO: 👆 ここ外だししたいが、 `lspconfig.util.root_pattern` に依存しているので考えるのがめんどい

      local augroup = vim.api.nvim_create_augroup('LspAttach', { clear = true })
      vim.api.nvim_create_autocmd({ 'LspAttach' }, {
        group = augroup,
        callback = function()
          local bufopts = { silent = true, buffer = bufnr, noremap = true }
          vim.keymap.set("n", "gk", openHover, bufopts)
          vim.keymap.set("n", "gj", openDiagnostics, bufopts)

          vim.keymap.set("n", "gn", vim.diagnostic.goto_next, bufopts)
          vim.keymap.set("n", "gN", vim.diagnostic.goto_next, bufopts)

          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<F3>", function() vim.lsp.buf.format({ async = true }) end, bufopts)
        end,
      })

      for name, v in pairs(server_preferences) do
        v.capabilities = capabilities
        vim.lsp.config(name, v)
      end
    end,
  },
  -- neodev.nvim ------------------------------
  {
    "aznhe21/actions-preview.nvim",
    dependencies = {
      --"kosayoda/nvim-lightbulb",
      "neovim/nvim-lspconfig",
    },
    lazy = true,
    event = { "LspAttach" },
    keys = {
      {
        "<leader><space>",
        "<Cmd>lua require('actions-preview').code_actions()<CR>",
        {
          buffer = bufnr,
          mode = "n",
          desc = "LSP: Code action",
        }
      },
    },
    config = function()
      require("actions-preview").setup({})
    end,
  },
}
