-- ---------------------------------------------------------------------------
-- CMDLINE POPUP VIEW CONFIG FOR NOICE-NVIM
-- ---------------------------------------------------------------------------

return {
  enabled = true,
  view = "cmdline_popup",
  opts = {
    cmdline_popup = {
      win_options = {
        winblend = 0,
      },
      scrollbar = false,
    },
  },
  format = {
    cmdline = { pattern = "^:", icon = "$", lang = "vim" },
    search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
    search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
    filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
    lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
    help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
    input = {},
  },
}
