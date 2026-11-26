return {
  lazy = true,
  "rachartier/tiny-cmdline.nvim",
  event = {
    "VeryLazy",
    "CmdlineEnter",
  },
  init = function()
    vim.o.cmdheight = 0
  end,
  opts = {
    position = {
      y = "20%",
    },
  },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, "TinyCmdlineBorder", { bg = "None" })
    vim.api.nvim_set_hl(0, "TinyCmdlineNormal", { bg = "None" })
    require("vim._core.ui2").enable({})
    require("tiny-cmdline").setup(opts)
  end,
}
