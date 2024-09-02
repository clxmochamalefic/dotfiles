return {
  {
    lazy = true,
    "uga-rosa/translate.nvim",
    event = { "BufEnter" },
    config = function()
      require("translate").setup({})
    end,
  },
  {
    lazy = true,
    "skanehira/denops-translate.vim",
    dependencies = {
      "vim-denops/denops.vim",
    },
    event = { "VeryLazy" },
    cmd = { "Translate", "TranslatePopup" },
  },
}
