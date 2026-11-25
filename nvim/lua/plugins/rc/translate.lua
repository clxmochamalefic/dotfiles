return {
  {
    lazy = true,
    "voldikss/vim-translator",
    cmd = { "Translate", "TranslatePopup" },
    keys = {
      { "gt", "<Plug>TranslateW", mode = "n", noremap = true },
      { "gt", "<Plug>TranslateWV", mode = "v", noremap = true },
    },
    init = function()
      vim.g.translator_target_lang = "ja"
    end,
  },
}
