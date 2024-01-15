-- ---------------------------------------------------------------------------
-- LSP LINT PLUGINS
-- ---------------------------------------------------------------------------

return {
  {
    lazy = true,
    "rshkarin/mason-nvim-lint",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-lint",
    },
    event = { 'LspAttach' },
    config = function()
      require("mason-nvim-lint").setup({
        ensure_installed = {
          'checkstyle',
          'eslint_d',
          'sonarlint-language-server',
          'tflint',
          'vacuum',
          'revive',
        },
      })
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end
  },
}

