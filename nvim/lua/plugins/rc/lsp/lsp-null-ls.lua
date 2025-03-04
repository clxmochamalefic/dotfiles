-- ---------------------------------------------------------------------------
-- NULL-LS (NONE-LS) PLUGINS
-- ---------------------------------------------------------------------------

--
-- HOW TO USE: null-ls
-- https://zenn.dev/takuya/articles/4472285edbc132#%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E3%83%95%E3%82%A9%E3%83%BC%E3%83%9E%E3%83%83%E3%82%BF%3A-prettier-and-null-ls
-- https://zenn.dev/yutti/articles/7baeec34836bc5
-- https://zenn.dev/fukakusa_kadoma/articles/32884de923fca1
--

local null_ls_config = require("plugins.rc.lsp.config.null-ls")

return {
  {
    lazy = true,
    cond = false, -- disable because that usage test for `stevearc/conform.nvim`
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "vim-test/vim-test",
      "neovim/nvim-lspconfig",
      "jay-babu/mason-null-ls.nvim",
    },
    events = {
      "FileReadPost",
      "BufRead",
    },
    opts = {},
    config = function()
      null_ls_config.setup()
    end,
  },
}
