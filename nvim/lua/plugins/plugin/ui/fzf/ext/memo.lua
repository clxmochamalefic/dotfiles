return {
  {
    lazy = true,
    "delphinus/telescope-memo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "glidenote/memolist.vim",
    },
    cmd = {
      -- memolist
      "Telescope memo list",
      "Telescope memo grep",
      "Telescope memo live_grep",
      "Telescope memo grep_string",
    },
    config = function()
      require("telescope").load_extension("memo")
    end,
  },
}
