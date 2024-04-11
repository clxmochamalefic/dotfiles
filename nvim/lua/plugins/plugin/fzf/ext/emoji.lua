local myutils = require("utils")

return {
  {
    lazy = true,
    "xiyaowong/telescope-emoji.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension("emoji")
    end,
  },
}
