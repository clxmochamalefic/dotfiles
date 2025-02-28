return {
  {
    lazy = true,
    "xiyaowong/telescope-emoji.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      'junegunn/fzf',
    },
    cmd = {
      "Telescope emoji",
    },
    keys = {
      { "<leader>e", "<Cmd>Telescope emoji<CR>", { mode = "n", desc = "Telescope: emoji" } },
    },
    config = function()
      require("telescope").load_extension("emoji")
    end,
  },
}
