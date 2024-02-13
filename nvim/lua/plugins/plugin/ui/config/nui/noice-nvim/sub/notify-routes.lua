-- ---------------------------------------------------------------------------
-- NOTIFY SUPPRESS AND MINIMIZE CONFIG FOR NOICE-NVIM PLUGIN
-- ---------------------------------------------------------------------------

local u = require("plugins.plugin.ui.config.nui.noice-nvim.util")

local suppressMessages = {
  u.notnmsg("^%d+ lines .ed %d+ times?$"),
  u.notnmsg("^%d+ lines yanked$"),
  u.notnmsg(".*E490.*", "emsg"),
  u.notnmsg("search_count"),

  u.notnmsg(".*E539.*", "emsg"),
  u.notnmsg(".*textDocument/hover.*"),
  u.notnmsg(".*textDocument/formatting.*"),
  u.notnmsg(".*textDocument/publishDiagnostics.*"),
  u.notnmsg(".*textDocument/signatureHelp.*"),
  u.notnmsg(".*WinResized Autocommands.*"),

  u.notnmsg(".*W*%s*%[1/1%].*"),

  u.notnmsg(".*nvim_opts%.lua.*", "echo"),
  u.notnmsg(".*nvim_opts%.lua.*", "echomsg"),

  u.notnmsg(".*%[ddc%] Not found source.*", "echo"),
  u.notnmsg(".*%[ddc%] Not found source.*", "echomsg"),
  u.notnmsg(".*%[ddc%] Not found source.*", "emsg"),

  u.notnmsg("^No code actions available$", "notify"),
  u.notnmsg("^No information available$", "notify"),
  u.notnmsg(".*nvim_opts%.lua.*", "lua_error"),
}

local suppressLsps = {
  u.notnlsp(".*textDocument/hover.*"),
  u.notnlsp(".*textDocument/formatting.*"),
  u.notnlsp(".*textDocument/publishDiagnostics.*"),
  u.notnlsp(".*textDocument/signatureHelp.*"),
  u.notnlsp("WinResized Autocommands"),
}

local suppressNotifies = {
  u.notnnotify(".*textDocument/hover.*"),
  u.notnnotify(".*textDocument/formatting.*"),
  u.notnnotify(".*textDocument/publishDiagnostics.*"),
  u.notnnotify(".*textDocument/signatureHelp.*"),
  u.notnnotify("WinResized Autocommands"),
  u.notnnotify("^%[ddc%] Not found source"),
  u.notnnotify("nvim_opts%.lua"),
}

local suppressNoices = {
  u.notnnoice(".*textDocument/hover.*"),
  u.notnnoice(".*textDocument/formatting.*"),
  u.notnnoice(".*textDocument/publishDiagnostics.*"),
  u.notnnoice(".*textDocument/signatureHelp.*"),
  u.notnnoice("WinResized Autocommands"),
  u.notnnoice("^%[ddc%] Not found source"),
  u.notnnoice("nvim_opts%.lua"),
}

local miniMessages = {
  u.nmsg("%d+L, %d+B"),
  u.nmsg("^%d+ changes?; after #%d+"),
  u.nmsg("^%d+ changes?; before #%d+"),
  u.nmsg("^Hunk %d+ of %d+$"),
  u.nmsg("^%d+ fewer lines;?"),
  u.nmsg("^%d+ more lines?;?"),
  u.nmsg("^%d+ line less;?"),
  u.nmsg("^Already at newest change"),
  u.nmsg(".*modifiable.*"),
  u.nmsg(".*Pick a window.*"),

  u.nmsg(".*%[denops%].*"),
  u.nmsg(".*%[hlchunk%.chunk%].*"),
  u.nmsg(".*%[lspconfig%].*"),

  u.nmsg("E486", "emsg"),
  u.nmsg(".*W*%s*%[1/1%].*", "search_count"),

  u.nmsg(".*Pick%sa%swindow.*", "echo"),
  u.nmsg("winpick", "echo"),
  u.nmsg(".*Pick%sa%swindow.*", "echomsg"),
  u.nmsg("winpick", "echomsg"),
  u.nmsg(".*LSP.*"),

  u.nmsg("", "wmsg"),
  u.nmsg("", "quickfix"),
  u.nmsg("", "quickfix"),
  u.nmsg("", "winpick"),
}

local miniLsps = {
  u.nlsp(".*LSP.*"),
  u.nlsp(".*%[lspconfig%].*"),
  u.nlsp(".*%[hlchunk%.chunk%].*"),
}

local miniNotifies = {
  u.nnotify(".*LSP.*"),
  u.nnotify(".*%[denops%].*"),
  u.nnotify(".*%[hlchunk%.chunk%].*"),
  u.nnotify(".*%[lspconfig%].*"),
}

local M = {
  routes = {
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
  },
}

return M
