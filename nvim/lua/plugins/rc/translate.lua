-- ---------------------------------------------------------------------------
-- TRANSLATE PLUGINS
-- ---------------------------------------------------------------------------

return {
  {
    lazy = true,
    "uga-rosa/translate.nvim",
    cmd = {
      "Translate",
    },
    keys = {
      { "tt", mode = {"n", "v"}, noremap = true, "<Cmd>Translate ja<CR>", desc = "show popup: translate to JA"  },
      { "tT", mode = {"n", "v"}, noremap = true, "<Cmd>Translate en<CR>", desc = "show popup: translate to EN"  },
      { "ty", mode = {"n", "v"}, noremap = true, "<Cmd>Translate ja -output=register<CR>", desc = "yank: translate to JA"  },
      { "tY", mode = {"n", "v"}, noremap = true, "<Cmd>Translate en -output=register<CR>", desc = "yank: translate to EN"  },
    },
    opts = {
      default = {
        command = "google",
        output = "floating",
      },
      preset = {
        output = {
          insert = {
            base = "top",
            off = -1,
          },
        },
      },
    },  -- opts
    config = true,
  },
}
