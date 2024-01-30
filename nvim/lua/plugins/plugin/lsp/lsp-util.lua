return {
  -- neodev.nvim ------------------------------
  {
    lazy = true,
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
  },
  --{
  --  -- vscode like 💡 sign
  --  lazy = true,
  --  cond = false,
  --  "kosayoda/nvim-lightbulb",
  --  event = { "BufRead" },
  --  dependencies = {
  --    "neovim/nvim-lspconfig",
  --  },
  --  config = function()
  --    --local default_config = require("plugins.lsp.config.lightbulb")
  --    local default_config = {}
  --    require("nvim-lightbulb").setup(default_config)
  --  end,
  --},
  {
    lazy = true,
    "aznhe21/actions-preview.nvim",
    event = { "LspAttach" },
    dependencies = {
      --"kosayoda/nvim-lightbulb",
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
      require("actions-preview").setup({})
    end,
  },
}

