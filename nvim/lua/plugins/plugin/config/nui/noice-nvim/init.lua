local function noiceWrapper(pattern, kind, ev)
  kind = kind or ""
  kind = kind or "msg_show"
  return {
    event = ev,
    kind = kind,
    find = pattern,
  }
end
local function suppressMsg(pattern, kind)
  return noiceWrapper(pattern, kind, "msg_show")
end
local function suppressLsp(pattern, kind)
  return noiceWrapper(pattern, kind, "lsp")
end
local function suppressNotify(pattern, kind)
  return noiceWrapper(pattern, kind, "notify")
end
local function suppressPopup(pattern, kind)
  return noiceWrapper(pattern, kind, "popup")
end

local suppressMessages = {
  suppressMsg("^.*lines.*$"),
  suppressMsg("^%d+ lines .ed %d+ times?$"),
  suppressMsg("^%d+ lines yanked$"),
  suppressMsg(".*E490.*", "emsg"),
  suppressMsg("search_count"),

  suppressMsg(".*E539.*", "emsg"),
  suppressMsg(".*textDocument/hover.*"),
  suppressMsg(".*textDocument/formatting.*"),
  suppressMsg(".*textDocument/publishDiagnostics.*"),
  suppressMsg(".*textDocument/signatureHelp.*"),
  suppressMsg(".*WinResized Autocommands.*"),

  suppressMsg(".*W* *%[1/1%].*"),

  suppressMsg(".*nvim_opts%.lua.*", "echo"),
  suppressMsg(".*nvim_opts%.lua.*", "echomsg"),

  suppressMsg(".*%[ddc%] Not found source.*", "echo"),
  suppressMsg(".*%[ddc%] Not found source.*", "echomsg"),
  suppressMsg(".*%[ddc%] Not found source.*", "emsg"),

  suppressMsg("^No code actions available$", "notify"),
  suppressMsg("^No information available$", "notify"),
  suppressMsg("^.*LSP.*$"),
  suppressMsg(".*nvim_opts%.lua.*", "lua_error"),
}

local suppressLsps = {
  suppressLsp(".*textDocument/hover.*"),
  suppressLsp(".*textDocument/formatting.*"),
  suppressLsp(".*textDocument/publishDiagnostics.*"),
  suppressLsp(".*textDocument/signatureHelp.*"),
  suppressLsp("WinResized Autocommands"),
  suppressLsp("^.*LSP.*$"),
}

local suppressNotifies = {
  suppressNotify(".*textDocument/hover.*"),
  suppressNotify(".*textDocument/formatting.*"),
  suppressNotify(".*textDocument/publishDiagnostics.*"),
  suppressNotify(".*textDocument/signatureHelp.*"),
  suppressNotify("WinResized Autocommands"),
  suppressNotify("^%[ddc%] Not found source"),
  suppressNotify("nvim_opts%.lua"),
  suppressNotify("^.*LSP.*$"),
}

local suppressPopups = {
  suppressPopup(".*textDocument/hover.*"),
  suppressPopup(".*textDocument/formatting.*"),
  suppressPopup(".*textDocument/publishDiagnostics.*"),
  suppressPopup(".*textDocument/signatureHelp.*"),
  suppressPopup("WinResized Autocommands"),
  suppressPopup("^%[ddc%] Not found source"),
  suppressPopup("nvim_opts%.lua"),
  suppressPopup("^.*LSP.*$"),
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
  noiceWrapper(".*W* *%[1/1%].*", "search_count"),

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

local M = {
  routes = {
    {
      filter = {
        event = "msg_show",
        any = suppressMessages,
      },
      opts = { skip = true, view = "notify" },
      view = "notify",
    },
    {
      filter = {
        event = "lsp",
        any = suppressLsps,
      },
      opts = { skip = true, view = "notify" },
      view = "notify",
    },
    {
      filter = {
        event = "notify",
        any = suppressNotifies,
      },
      opts = { skip = true, view = "notify" },
      view = "notify",
    },
    {
      filter = {
        event = "popup",
        any = suppressPopups,
      },
      opts = { skip = true, view = "notify" },
    },
    {
      filter = {
        event = "msg_show",
        any = miniMessages,
      },
      view = "mini",
    },
    --{
    --  filter = {
    --    event = "lsp",
    --    any = miniLsps,
    --  },
    --  view = "mini",
    --},
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
