return {
  {
    lazy = true,
    "skanehira/denops-translate.vim",
    cmd = { "Translate", "TranslatePopup" },
    dependencies = {
      "vim-denops/denops.vim",
    },
    keys = {
      { "<leader>t", "<Plug>(Translate)", { mode = "n", noremap = true } },
      { "<leader>t", "<Plug>(Translate)", { mode = "v", noremap = true } },
    },
    config = function()
      vim.keymap.set("", "<leader>q", M.CloseAllFloatingWindows, { noremap = true })
    end,
  },
}
