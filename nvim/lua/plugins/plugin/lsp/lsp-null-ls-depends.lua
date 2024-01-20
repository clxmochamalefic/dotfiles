-- ---------------------------------------------------------------------------
-- NULL-LS (NONE-LS) DEPENDENCIES PLUGINS
-- ---------------------------------------------------------------------------

local ft = {
  "css",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "json",
  "scss",
  "less",
}

return {
  {
    lazy = true,
    cond = false, -- disable because that usage test for `stevearc/conform.nvim`
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
    event = { "FileReadPost" },
    opts = {},
    config = function()
      require("mason-null-ls").setup({
        automatic_setup = true,
        ensure_installed = nil,
        automatic_installation = {
          exclude = {
            "textlint",
          },
        },
        handlers = {
          function(source_name, methods)
            require("mason-null-ls.automatic_setup")(source_name, methods)
          end,
        },
      })
    end,
  },
  --{
  --  lazy = true,
  --  'MunifTanjim/prettier.nvim',
  --  dependencies = {
  --    'neovim/nvim-lspconfig',
  --    "nvimtools/none-ls.nvim",
  --  },
  --  event = { 'FileReadPost', },
  --  build = 'npm install -g @fsouza/prettierd',
  --  opts = {},
  --  config = function()
  --    local status, prettier = pcall(require, "prettier")
  --    if (not status) then return end

  --    prettier.setup {
  --      bin = 'prettierd',
  --      filetypes = ft
  --    }
  --  end,
  --}
}
