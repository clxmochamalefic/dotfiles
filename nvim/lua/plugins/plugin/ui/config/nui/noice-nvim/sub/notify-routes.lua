-- ---------------------------------------------------------------------------
-- NOTIFY SUPPRESS AND MINIMIZE CONFIG FOR NOICE-NVIM PLUGIN
-- ---------------------------------------------------------------------------

local u = require("plugins.plugin.ui.config.nui.noice-nvim.util")
local n = u.noice

local suppressMessages = {
  n.msg("^%d+ lines .ed %d+ times?$"),
  n.msg("^%d+ lines yanked$"),
  n.msg(".*E490.*", "emsg"),
  n.msg("search_count"),

  n.msg(".*E539.*", "emsg"),
  n.msg(".*textDocument/hover.*"),
  n.msg(".*textDocument/formatting.*"),
  n.msg(".*textDocument/publishDiagnostics.*"),
  n.msg(".*textDocument/signatureHelp.*"),
  n.msg(".*WinResized Autocommands.*"),

  n.msg(".*W*%s*%[1/1%].*"),

  n.msg(".*nvim_opts%.lua.*", "echo"),
  n.msg(".*nvim_opts%.lua.*", "echomsg"),

  n.msg(".*%[ddc%] Not found source.*", "echo"),
  n.msg(".*%[ddc%] Not found source.*", "echomsg"),
  n.msg(".*%[ddc%] Not found source.*", "emsg"),

  n.msg("^No code actions available$", "notify"),
  n.msg("^No information available$", "notify"),
  n.msg(".*nvim_opts%.lua.*", "lua_error"),
}

local suppressLsps = {
  n.lsp(".*textDocument/hover.*"),
  n.lsp(".*textDocument/formatting.*"),
  n.lsp(".*textDocument/publishDiagnostics.*"),
  n.lsp(".*textDocument/signatureHelp.*"),
  n.lsp("WinResized Autocommands"),
}

local suppressNotifies = {
  n.notify(".*textDocument/hover.*"),
  n.notify(".*textDocument/formatting.*"),
  n.notify(".*textDocument/publishDiagnostics.*"),
  n.notify(".*textDocument/signatureHelp.*"),
  n.notify("WinResized Autocommands"),
  n.notify("^%[ddc%] Not found source"),
  n.notify("nvim_opts%.lua"),
}

local suppressNoices = {
  n.noice(".*textDocument/hover.*"),
  n.noice(".*textDocument/formatting.*"),
  n.noice(".*textDocument/publishDiagnostics.*"),
  n.noice(".*textDocument/signatureHelp.*"),
  n.noice("WinResized Autocommands"),
  n.noice("^%[ddc%] Not found source"),
  n.noice("nvim_opts%.lua"),
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
