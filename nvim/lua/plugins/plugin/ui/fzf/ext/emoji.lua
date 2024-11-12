local myutils = require("utils")

return {
  {
    lazy = true,
    "xiyaowong/telescope-emoji.nvim",
    cmd = {
      "Telescope emoji",
    }
    config = function()
      require("telescope").load_extension("emoji")
    end,
  },
}
