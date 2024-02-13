-- ---------------------------------------------------------------------------
-- NOTIFY SUPPRESS AND MINIMIZE CONFIG FOR NOICE-NVIM PLUGIN
-- ---------------------------------------------------------------------------

local u = require("plugins.plugin.ui.config.nui.noice-nvim.util")
local n = u.noice

local suppressMessages = {
  n.not_msg("^%d+ lines .ed %d+ times?$"),
  n.not_msg("^%d+ lines yanked$"),
  n.not_msg(".*E490.*", "emsg"),
  n.not_msg("search_count"),

  n.not_msg(".*E539.*", "emsg"),
  n.not_msg(".*textDocument/hover.*"),
  n.not_msg(".*textDocument/formatting.*"),
  n.not_msg(".*textDocument/publishDiagnostics.*"),
  n.not_msg(".*textDocument/signatureHelp.*"),
  n.not_msg(".*WinResized Autocommands.*"),

  n.not_msg(".*W*%s*%[1/1%].*"),

  n.not_msg(".*nvim_opts%.lua.*", "echo"),
  n.not_msg(".*nvim_opts%.lua.*", "echomsg"),

  n.not_msg(".*%[ddc%] Not found source.*", "echo"),
  n.not_msg(".*%[ddc%] Not found source.*", "echomsg"),
  n.not_msg(".*%[ddc%] Not found source.*", "emsg"),

  n.not_msg("^No code actions available$", "notify"),
  n.not_msg("^No information available$", "notify"),
  n.not_msg(".*nvim_opts%.lua.*", "lua_error"),
}

local suppressLsps = {
  n.not_lsp(".*textDocument/hover.*"),
  n.not_lsp(".*textDocument/formatting.*"),
  n.not_lsp(".*textDocument/publishDiagnostics.*"),
  n.not_lsp(".*textDocument/signatureHelp.*"),
  n.not_lsp("WinResized Autocommands"),
}

local suppressNotifies = {
  n.not_notify(".*textDocument/hover.*"),
  n.not_notify(".*textDocument/formatting.*"),
  n.not_notify(".*textDocument/publishDiagnostics.*"),
  n.not_notify(".*textDocument/signatureHelp.*"),
  n.not_notify("WinResized Autocommands"),
  n.not_notify("^%[ddc%] Not found source"),
  n.not_notify("nvim_opts%.lua"),
}

local suppressNoices = {
  n.not_noice(".*textDocument/hover.*"),
  n.not_noice(".*textDocument/formatting.*"),
  n.not_noice(".*textDocument/publishDiagnostics.*"),
  n.not_noice(".*textDocument/signatureHelp.*"),
  n.not_noice("WinResized Autocommands"),
  n.not_noice("^%[ddc%] Not found source"),
  n.not_noice("nvim_opts%.lua"),
}

local miniMessages = {
  n.msg("%d+L, %d+B"),
  n.msg("^%d+ changes?; after #%d+"),
  n.msg("^%d+ changes?; before #%d+"),
  n.msg("^Hunk %d+ of %d+$"),
  n.msg("^%d+ fewer lines;?"),
  n.msg("^%d+ more lines?;?"),
  n.msg("^%d+ line less;?"),
  n.msg("^Already at newest change"),
  n.msg(".*modifiable.*"),
  n.msg(".*Pick a window.*"),

  n.msg(".*%[denops%].*"),
  n.msg(".*%[hlchunk%.chunk%].*"),
  n.msg(".*%[lspconfig%].*"),

  n.msg("E486", "emsg"),
  n.msg(".*W*%s*%[1/1%].*", "search_count"),

  n.msg(".*Pick%sa%swindow.*", "echo"),
  n.msg("winpick", "echo"),
  n.msg(".*Pick%sa%swindow.*", "echomsg"),
  n.msg("winpick", "echomsg"),
  n.msg(".*LSP.*"),

  n.msg("", "winpick"),
}

local miniLsps = {
  n.lsp(".*LSP.*"),
  n.lsp(".*%[lspconfig%].*"),
  n.lsp(".*%[hlchunk%.chunk%].*"),
}

local miniNotifies = {
  n.notify(".*LSP.*"),
  n.notify(".*%[denops%].*"),
  n.notify(".*%[hlchunk%.chunk%].*"),
  n.notify(".*%[lspconfig%].*"),
}

local miniNoice = {
  n.noice(".*LSP.*"),
  n.noice(".*%[denops%].*"),
  n.noice(".*%[hlchunk%.chunk%].*"),
  n.noice(".*%[lspconfig%].*"),
}

local M = {
  {
    filter = {
      any = miniMessages,
    },
    view = "mini",
  },
  {
    filter = {
      any = miniLsps,
    },
    view = "mini",
  },
  {
    filter = {
      any = miniNotifies,
    },
    view = "mini",
  },
  {
    filter = {
      any = miniNoice,
    },
    view = "mini",
  },

  {
    opts = { skip = true },
    filter = {
      any = suppressMessages,
    },
  },
  {
    opts = { skip = true },
    filter = {
      any = suppressLsps,
    },
  },
  {
    opts = { skip = true },
    filter = {
      any = suppressNotifies,
    },
  },
  {
    opts = { skip = true },
    filter = {
      any = suppressNoices,
    },
  },
}

return M
