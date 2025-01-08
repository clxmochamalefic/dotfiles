---@diagnostic disable: undefined-global
return {
  {
    "clxmochamalefic/lspctl.nvim",
    lazy = false,
    --dir = vim.g.my_home_path .. "/repos/my/plugins/lspctl.nvim",
    --dev = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
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
