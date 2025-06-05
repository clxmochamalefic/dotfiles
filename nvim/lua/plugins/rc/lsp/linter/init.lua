-- ---------------------------------------------------------------------------
-- LSP LINT PLUGINS
-- ---------------------------------------------------------------------------

local g = vim.g

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

      local cv = async.control.Condvar.new()

      async.run(function()
        while g.mason_ready == nil or g.mason_ready == false do
          async.util.sleep(1000)
          --print("mason-nvim-lint: Waiting for mason to be ready")
        end
        vim.notify("mason-nvim-lint: GET READY!!")
        cv:notify_all()
      end)

      async.run(function()
        cv:wait()

        require("mason-nvim-lint").setup({
          ensure_installed = {
            "checkstyle",
            "eslint_d",
            "sonarlint-language-server",
            "tflint",
            "vacuum",
            "revive",
          },
        })

        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
          callback = function()
            require("lint").try_lint()
          end,
        })
      end)
    end,
  },
}
