--
-- null-ls依存のLSP設定
--

local ft = {
  "css",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "json",
  "scss",
  "less"
}

return {
  {
    lazy = true,
    'jay-babu/mason-null-ls.nvim',
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
    events = { 'FileReadPost', },
    opts = {},
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
    lazy = true,
    'MunifTanjim/prettier.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'jose-elias-alvarez/null-ls.nvim',
    },
    events = { 'FileReadPost', },
    build = 'npm install -g @fsouza/prettierd',
    opts = {},
    config = function()
      local status, prettier = pcall(require, "prettier")
      if (not status) then return end

      prettier.setup {
        bin = 'prettierd',
        filetypes = ft
      }
    end,
  }
}
