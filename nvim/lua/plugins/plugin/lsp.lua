-- LSP ------------------------------

---@diagnostic disable: unused-local

local myutils = require 'utils'
local nvim_lsputils = require'plugins.plugin.config.lsp.lsputils'

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

local icons = {
  package_installed = "✓",
  package_uninstalled = "✗",
  package_pending = "⟳",
}

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
  "lua_ls",
}

local pattern_opts = {
  ["tsserver"] = function(lspconfig, opts)
    local is_node = require("lspconfig").util.find_node_modules_ancestor(".")
    --if is_node and (not enabled_vtsls) then
    --  lspconfig["tsserver"].setup({})
    --end
    if is_node then
      lspconfig["tsserver"].setup({})
    end
  end,
  ["denols"] = function(lspconfig, opts)
    lspconfig["denols"].setup({
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc", "deps.ts", "import_map.json"),
      init_options = {
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
        },
      },
    })
  end,
}

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
  api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    group = "lspconfig-enable-diagnostics-hover",
    callback = function()
      api.nvim_clear_autocmds({ group = "lspconfig-enable-diagnostics-hover" })
      enable_diagnostics_hover()
    end,
  })
end

local formatting_callback = function(client, bufnr)
  keymap.set("n", "<Leader>f", function()
    local params = require('vim.lsp.util').make_formatting_params({})
    client.request("textDocument/formatting", params, nil, bufnr)
  end, { buffer = bufnr })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "rcarriga/nvim-notify",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    cmd = {
      "LspInstall",
      "LspUninstall",
      "LspInfo",
    },
    config = function()
      -- general settings
      diagnostic.config({
        float = {
          source = "always", -- Or "if_many"
        },
      })
      lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        lsp.diagnostic.on_publish_diagnostics,
        {
          virtual_text = {
            format = function(diagnostic)
              return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
            end
          }
        }
      )
      lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
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

      vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

      local capabilities = lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      require("mason").setup()
      local lspconfig = require "lspconfig"
      local malspconfig = require "mason-lspconfig"

      local on_attach = function(client, bufnr)
        local async = require("plenary.async")
        local notify = require("notify").async
        myutils.io.debug_echo("LSP started" .. client.name)
        async.run(function()
          notify("LSP started: " .. client.name).events.close()
        end)


        local bufopts = { silent = true, buffer = bufnr }
        keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        keymap.set('n', 'gx', vim.lsp.buf.type_definition, bufopts)
        keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        keymap.set('n', 'gX', vim.lsp.buf.references, bufopts)
        keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
        keymap.set('n', '<F3>', function() vim.lsp.buf.format { async = true } end, bufopts)


        keymap.set('n', '<leader>,',  lsp.buf.code_action,  { desc = 'show: code actions', })
      end

      malspconfig.setup({
        ensure_installed = servers,
        automatic_installation = true,
      })
      malspconfig.setup_handlers({
        function(server_name)
          local opts = {
            on_attach = on_attach,
            capabilities = capabilities,
          }

          if myutils.isContainsInArray(pattern_opts, server_name) then
            pattern_opts[server_name](lspconfig, opts)
            return
          end
          lspconfig[server_name].setup(opts)
        end,
      })

      --local augroup_id = api.nvim_create_augroup("my_lspinfo_preference", { clear = true })
      --api.nvim_create_autocmd("FileType", {
      --  group = augroup_id,
      --  pattern = { "lspinfo" },
      --  callback = function()
      --    --ddu_ff_my_settings()
      --  end,
      --})

      myutils.io.end_debug("ddu ff")
    end,
  },
  {
    --lazy = true,
    "williamboman/mason.nvim",
    dependencies = {
      "vim-denops/denops.vim",
      "mfussenegger/nvim-dap",
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
        icons = icons,
      },
    },
    config = function()
    end,
  },
  {
    --lazy = true,
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "vim-denops/denops.vim",
      "mfussenegger/nvim-dap",
    },
    --    opts = function(_, opts)
    --      if not opts.handlers then
    --        opts.handlers = {}
    --      end
    --      opts.handlers[1] = function(server)
    --        require("myutils.lsp").setup(server)
    --      end
    --    end,
    config = function()
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
    lazy = true,
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
  },
  {
    lazy = true,
    'kosayoda/nvim-lightbulb',
    events = { 'BufRead' },
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      local default_config = {
        -- Priority of the lightbulb for all handlers except float.
        priority = 10,

        -- Whether or not to hide the lightbulb when the buffer is not focused.
        -- Only works if configured during NvimLightbulb.setup
        hide_in_unfocused_buffer = true,

        -- Whether or not to link the highlight groups automatically.
        -- Default highlight group links:
        --   LightBulbSign -> DiagnosticSignInfo
        --   LightBulbFloatWin -> DiagnosticFloatingInfo
        --   LightBulbVirtualText -> DiagnosticVirtualTextInfo
        --   LightBulbNumber -> DiagnosticSignInfo
        --   LightBulbLine -> CursorLine
        -- Only works if configured during NvimLightbulb.setup
        link_highlights = true,

        -- Perform full validation of configuration.
        -- Available options: "auto", "always", "never"
        --   "auto" only performs full validation in NvimLightbulb.setup.
        --   "always" performs full validation in NvimLightbulb.update_lightbulb as well.
        --   "never" disables config validation.
        validate_config = "auto",

        -- Code action kinds to observe.
        -- To match all code actions, set to `nil`.
        -- Otherwise, set to a table of kinds.
        -- Example: { "quickfix", "refactor.rewrite" }
        -- See: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#codeActionKind
        action_kinds = nil,

        -- Configuration for various handlers:
        -- 1. Sign column.
        sign = {
          enabled = true,
          -- Text to show in the sign column.
          -- Must be between 1-2 characters.
          text = "💡",
          -- Highlight group to highlight the sign column text.
          hl = "LightBulbSign",
        },

        -- 2. Virtual text.
        virtual_text = {
          enabled = false,
          -- Text to show in the virt_text.
          text = "💡",
          -- Position of virtual text given to |nvim_buf_set_extmark|.
          -- Can be a number representing a fixed column (see `virt_text_pos`).
          -- Can be a string representing a position (see `virt_text_win_col`).
          pos = "eol",
          -- Highlight group to highlight the virtual text.
          hl = "LightBulbVirtualText",
          -- How to combine other highlights with text highlight.
          -- See `hl_mode` of |nvim_buf_set_extmark|.
          hl_mode = "combine",
        },

        -- 3. Floating window.
        float = {
          enabled = false,
          -- Text to show in the floating window.
          text = "💡",
          -- Highlight group to highlight the floating window.
          hl = "LightBulbFloatWin",
          -- Window options.
          -- See |vim.lsp.util.open_floating_preview| and |nvim_open_win|.
          -- Note that some options may be overridden by |open_floating_preview|.
          win_opts = {
            focusable = false,
          },
        },

        -- 4. Status text.
        -- When enabled, will allow using |NvimLightbulb.get_status_text|
        -- to retrieve the configured text.
        status_text = {
          enabled = false,
          -- Text to set if a lightbulb is available.
          text = "💡",
          -- Text to set if a lightbulb is unavailable.
          text_unavailable = "",
        },

        -- 5. Number column.
        number = {
          enabled = false,
          -- Highlight group to highlight the number column if there is a lightbulb.
          hl = "LightBulbNumber",
        },

        -- 6. Content line.
        line = {
          enabled = false,
          -- Highlight group to highlight the line if there is a lightbulb.
          hl = "LightBulbLine",
        },

        -- Autocmd configuration.
        -- If enabled, automatically defines an autocmd to show the lightbulb.
        -- If disabled, you will have to manually call |NvimLightbulb.update_lightbulb|.
        -- Only works if configured during NvimLightbulb.setup
        autocmd = {
          -- Whether or not to enable autocmd creation.
          --enabled = false,
          enabled = true,
          -- See |updatetime|.
          -- Set to a negative value to avoid setting the updatetime.
          updatetime = 200,
          -- See |nvim_create_autocmd|.
          events = { "CursorHold", "CursorHoldI" },
          -- See |nvim_create_autocmd| and |autocmd-pattern|.
          pattern = { "*" },
        },

        -- Scenarios to not show a lightbulb.
        ignore = {
          -- LSP client names to ignore.
          -- Example: {"null-ls", "lua_ls"}
          clients = {},
          -- Filetypes to ignore.
          -- Example: {"neo-tree", "lua"}
          ft = {},
          -- Ignore code actions without a `kind` like refactor.rewrite, quickfix.
          actions_without_kind = false,
        },
      }
      require("nvim-lightbulb").setup(default_config)

    end
  },
  {
    lazy = true,
    "aznhe21/actions-preview.nvim",
    event = { 'LspAttach' },
    dependencies = {
      'kosayoda/nvim-lightbulb',
      "neovim/nvim-lspconfig",
    },
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Setup code action preview",
        callback = function(args)
          local bufnr = args.buf

          vim.keymap.set("n", "<leader><space>", function()
            require("actions-preview").code_actions()
          end, { buffer = bufnr, desc = "LSP: Code action" })
        end,
      })
    end,
    config = function()
      require("actions-preview").setup {}
    end,
  },
  {
    lazy = true,
    'RishabhRD/nvim-lsputils',
    event = {
      'VimEnter',
    },
    dependencies = {
      'RishabhRD/popfix',
    },
    config = function()
      nvim_lsputils.setup()
      --if fn.has('nvim-0.5.1') == 1 then
      --  lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
      --  lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
      --  lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
      --  lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
      --  lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
      --  lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
      --  lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
      --  lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
      --else
      --  local bufnr = vim.api.nvim_buf_get_number(0)

      --  vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
      --    require('lsputil.codeAction').code_action_handler(nil, actions, nil, nil, nil)
      --  end

      --  vim.lsp.handlers['textDocument/references'] = function(_, _, result)
      --    require('lsputil.locations').references_handler(nil, result, { bufnr = bufnr }, nil)
      --  end

      --  vim.lsp.handlers['textDocument/definition'] = function(_, method, result)
      --    require('lsputil.locations').definition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
      --  end

      --  vim.lsp.handlers['textDocument/declaration'] = function(_, method, result)
      --    require('lsputil.locations').declaration_handler(nil, result, { bufnr = bufnr, method = method }, nil)
      --  end

      --  vim.lsp.handlers['textDocument/typeDefinition'] = function(_, method, result)
      --    require('lsputil.locations').typeDefinition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
      --  end

      --  vim.lsp.handlers['textDocument/implementation'] = function(_, method, result)
      --    require('lsputil.locations').implementation_handler(nil, result, { bufnr = bufnr, method = method }, nil)
      --  end

      --  vim.lsp.handlers['textDocument/documentSymbol'] = function(_, _, result, _, bufn)
      --    require('lsputil.symbols').document_handler(nil, result, { bufnr = bufn }, nil)
      --  end

      --  vim.lsp.handlers['textDocument/symbol'] = function(_, _, result, _, bufn)
      --    require('lsputil.symbols').workspace_handler(nil, result, { bufnr = bufn }, nil)
      --  end
      --end
    end,
  },
}


