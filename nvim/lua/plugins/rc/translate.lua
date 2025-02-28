return {
  {
    "skanehira/denops-translate.vim",
    dependencies = {
      "vim-denops/denops.vim",
    },
    lazy = true,
    cmd = { "Translate", "TranslatePopup" },
    keys = {
      { "<leader>t", "<Plug>(Translate)", { mode = "n", noremap = true } },
      { "<leader>t", "<Plug>(Translate)", { mode = "v", noremap = true } },
    },
    config = function()
      --vim.keymap.set("", "<leader>q", M.CloseAllFloatingWindows, { noremap = true })
    end,
  },
}
