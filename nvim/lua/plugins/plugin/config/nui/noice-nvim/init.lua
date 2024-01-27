local function noiceWrapper(pattern, kind)
  kind = kind or ""
  return {
    event = "msg_show",
    kind = kind,
    find = pattern,
  }
end

local suppressMessages = {
  noiceWrapper("^%d+ lines .ed %d+ times?$"),
  noiceWrapper("^%d+ lines yanked$"),
  noiceWrapper(".*E490.*", "emsg"),
  noiceWrapper("search_count"),

  noiceWrapper(".*E539.*", "emsg"),
  noiceWrapper(".*textDocument/hover.*"),
  noiceWrapper(".*textDocument/formatting.*"),
  noiceWrapper(".*textDocument/publishDiagnostics.*"),
  noiceWrapper(".*textDocument/signatureHelp.*"),
  noiceWrapper(".*WinResized Autocommands.*"),

  noiceWrapper(".*W*%s*%[1/1%].*"),

  noiceWrapper(".*nvim_opts%.lua.*", "echo"),
  noiceWrapper(".*nvim_opts%.lua.*", "echomsg"),

  noiceWrapper(".*%[ddc%] Not found source.*", "echo"),
  noiceWrapper(".*%[ddc%] Not found source.*", "echomsg"),
  noiceWrapper(".*%[ddc%] Not found source.*", "emsg"),

  noiceWrapper("^No code actions available$", "notify"),
  noiceWrapper("^No information available$", "notify"),
  --noiceWrapper("^LSP%sstarted:.*", "notify"),
  noiceWrapper(".*LSP.*"),
  noiceWrapper(".*nvim_opts%.lua.*", "lua_error"),

  --noiceWrapper("^LSP%sstarted.*"),
  --noiceWrapper("^LSP%sstarted.*", "notify"),
  --noiceWrapper("LSP started", "notify"),
  --noiceWrapper(".*LSP started.*"),
  --noiceWrapper("^LSP%sstarted.*", "echo"),
  --noiceWrapper("^LSP%sstarted.*", "echomsg"),
  --noiceWrapper("^LSP%sstarted.*", "emsg"),
  --noiceWrapper("^LSP started.*", "notify"),
  --noiceWrapper("^LSP started.*", "echo"),
  --noiceWrapper("^LSP started.*", "echomsg"),
  --noiceWrapper("^LSP started.*", "emsg"),
}

local suppressLsps = {
  noiceWrapper(".*textDocument/hover.*"),
  noiceWrapper(".*textDocument/formatting.*"),
  noiceWrapper(".*textDocument/publishDiagnostics.*"),
  noiceWrapper(".*textDocument/signatureHelp.*"),
  noiceWrapper("WinResized Autocommands"),
  --noiceWrapper(".*LSP started.*"),
  noiceWrapper(".*LSP.*"),
  --noiceWrapper("LSP started"),
}

local suppressNotifies = {
  noiceWrapper(".*textDocument/hover.*"),
  noiceWrapper(".*textDocument/formatting.*"),
  noiceWrapper(".*textDocument/publishDiagnostics.*"),
  noiceWrapper(".*textDocument/signatureHelp.*"),
  noiceWrapper("WinResized Autocommands"),
  noiceWrapper("^%[ddc%] Not found source"),
  noiceWrapper("nvim_opts%.lua"),
  --noiceWrapper("LSP started"),
  noiceWrapper(".*LSP.*"),
  --noiceWrapper(".*LSP started.*"),
}

local miniMessages = {
  noiceWrapper("%d+L, %d+B"),
  noiceWrapper("^%d+ changes?; after #%d+"),
  noiceWrapper("^%d+ changes?; before #%d+"),
  noiceWrapper("^Hunk %d+ of %d+$"),
  noiceWrapper("^%d+ fewer lines;?"),
  noiceWrapper("^%d+ more lines?;?"),
  noiceWrapper("^%d+ line less;?"),
  noiceWrapper("^Already at newest change"),
  noiceWrapper(".*modifiable.*"),
  noiceWrapper(".*Pick a window.*"),

  noiceWrapper(".*%[denops%].*"),
  noiceWrapper(".*%[hlchunk%.chunk%].*"),
  noiceWrapper(".*%[lspconfig%].*"),

  noiceWrapper("E486", "emsg"),
  noiceWrapper(".*W*%s*%[1/1%].*", "search_count"),

  noiceWrapper(".*Pick%sa%swindow.*", "echo"),
  noiceWrapper("winpick", "echo"),
  noiceWrapper(".*Pick%sa%swindow.*", "echomsg"),
  noiceWrapper("winpick", "echomsg"),
  --noiceWrapper("LSP started"),
  noiceWrapper(".*LSP.*"),
  --noiceWrapper(".*LSP started.*"),

  noiceWrapper("", "wmsg"),
  noiceWrapper("", "quickfix"),
  noiceWrapper("", "quickfix"),
  noiceWrapper("", "winpick"),
}

local miniLsps = {
  noiceWrapper(".*%[lspconfig%].*"),
  noiceWrapper(".*%[hlchunk%.chunk%].*"),
}

local miniNotifies = {
  noiceWrapper(".*%[denops%].*"),
  noiceWrapper(".*%[hlchunk%.chunk%].*"),
  noiceWrapper(".*%[lspconfig%].*"),
}

local routes = {}
for _, v in pairs(suppressMessages) do
  table.insert(routes, v)
end
for _, v in pairs(miniMessages) do
  table.insert(routes, v)
end

local M = {
  routes = {
    {
      filter = {
        event = "msg_show",
        any = suppressMessages,
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = "lsp",
        any = suppressLsps,
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = "notify",
        any = suppressNotifies,
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = "msg_show",
        any = miniMessages,
      },
      view = "mini",
    },
    {
      filter = {
        event = "lsp",
        any = miniLsps,
      },
      view = "mini",
    },
    {
      filter = {
        event = "notify",
        any = miniNotifies,
      },
      view = "mini",
    },
  },
}

--function M.setup(noice) end

return M
