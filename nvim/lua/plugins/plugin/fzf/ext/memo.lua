return {
  {
    "delphinus/telescope-memo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "glidenote/memolist.vim",
    },
    config = function()
      require("telescope").load_extension("memo")
    end,
  },
}
