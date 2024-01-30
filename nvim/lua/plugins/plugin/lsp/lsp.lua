-- ---------------------------------------------------------------------------
-- LSP COMMON PLUGINS
-- ---------------------------------------------------------------------------

local g = vim.g
local o = vim.o
--local fn = vim.fn
local api = vim.api
local lsp = vim.lsp
--local opt = vim.opt
local keymap = vim.keymap
local diagnostic = vim.diagnostic

local myutils = require("utils")
local myserver = require("plugins.plugin.lsp.config.server")
local myignore = require("plugins.plugin.lsp.config.ignore")
local mylspconfig = require("plugins.plugin.lsp.config")

local icons = {
  package_installed = "✓",
  package_uninstalled = "✗",
  package_pending = "⟳",
}

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
      g.mason_ready = false

      require("mason").setup()
      local lspconfig = require("lspconfig")

      -- my lsp server setting setup
      mylspconfig.setup()
      myserver.setup()

      -- --------------------
      -- mason-lspconfig setup
      -- --------------------
      local malspconfig = require("mason-lspconfig")
      malspconfig.setup({
        --ensure_installed = servers,
        ensure_installed = myserver.servers,
        automatic_installation = true,
      })

      -- setup ensure installed LSP servers in mason registry
      local opts = {
        on_attach = mylspconfig.on_attach,
        capabilities = mylspconfig.get_capabilities(),
      }

      malspconfig.setup_handlers({
        function(server_name)
          myserver.setupToServerByName(lspconfig, server_name, opts)
        end,
      })

      -- setup ensure installed LSP servers out of mason registry
      myserver.setupToServerForNoMasons(lspconfig, opts)

      g.mason_ready = true

      myutils.io.end_debug("nvim-lspconfig")
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
    keys = {
      { "<F12>", "<Cmd>Mason<CR>", { mode = "n", silent = true, desc = "mason" } },
    },
    opts = {
      ui = {
        icons = icons,
      },
    },
    config = function() end,
  },
  {
    --lazy = true,
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "vim-denops/denops.vim",
      "mfussenegger/nvim-dap",
    },
  },
}
