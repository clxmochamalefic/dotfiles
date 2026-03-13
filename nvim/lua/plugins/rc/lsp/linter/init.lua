-- ---------------------------------------------------------------------------
-- LSP LINT PLUGINS
-- ---------------------------------------------------------------------------

local g = vim.g

local function trylint()
  require("lint").try_lint()
end

return {
  {
    lazy = true,
    "rshkarin/mason-nvim-lint",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-lint",
      "nvim-lua/plenary.nvim",
    },
    event = { "LspAttach" },
    config = function()
      local async = require("plenary.async")

      require("mason-nvim-lint").setup({
        ensure_installed = {
          --"checkstyle",
          --"eslint_d",
          --"sonarlint-language-server",
          --"tflint",
          --"vacuum",
          --"revive",
        },
        automatic_installation = true,
      })

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = trylint,
      })

      vim.api.nvim_create_user_command("TryLint", trylint, {})
    end,
  },
}
