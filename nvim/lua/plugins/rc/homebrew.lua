---@diagnostic disable: undefined-global
return {
  {
    "clxmochamalefic/lspctl.nvim",
    dependencies = {
      'vim-denops/denops.vim',
      "neovim/nvim-lspconfig",
    },
    cmd = { "Lspctl", },
    opts = {
      manager = "mason",
    },
    config = function(_, opts)
      require("lspctl").setup(opts)
    end
  },
  {
    "clxmochamalefic/lspctl.denops",
    lazy = false,
    dir = vim.g.my_home_path .. "/repos/plugins/lspctl.denops",
    dev = true,
    dependencies = {
      'vim-denops/denops.vim',
      "neovim/nvim-lspconfig",
    },
    cmd = { "Lspctl", },
    opts = {
      manager = "mason",
    },
    config = function(_, opts)
      require("lspctl").setup(opts)
    end
  },
}
