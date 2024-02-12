local function noiceWrapper(pattern, kind, event)
  kind = kind or ""
  event = event or "msg_show"

  return {
    event = event,
    kind = kind,
    find = pattern,
  }
end

local function noiceNotWrapper(pattern, kind, event)
  kind = kind or ""
  event = event or "msg_show"

  return {
    ["not"] = {
      event = event,
      kind = kind,
      find = pattern,
    },
  }
end

local function notnmsg(pattern, kind)
  return noiceNotWrapper(pattern, kind, "msg_show")
end

local function notnlsp(pattern, kind)
  return noiceNotWrapper(pattern, kind, "lsp")
end

local function notnnotify(pattern, kind)
  return noiceNotWrapper(pattern, kind, "notify")
end

local function notnnoice(pattern, kind)
  return noiceNotWrapper(pattern, kind, "noice")
end

local function nmsg(pattern, kind)
  return noiceWrapper(pattern, kind, "msg_show")
end

local function nlsp(pattern, kind)
  return noiceWrapper(pattern, kind, "lsp")
end

local function nnotify(pattern, kind)
  return noiceWrapper(pattern, kind, "notify")
end

local function nnoice(pattern, kind)
  return noiceWrapper(pattern, kind, "noice")
end

local suppressMessages = {
  notnmsg("^%d+ lines .ed %d+ times?$"),
  notnmsg("^%d+ lines yanked$"),
  notnmsg(".*E490.*", "emsg"),
  notnmsg("search_count"),

  notnmsg(".*E539.*", "emsg"),
  notnmsg(".*textDocument/hover.*"),
  notnmsg(".*textDocument/formatting.*"),
  notnmsg(".*textDocument/publishDiagnostics.*"),
  notnmsg(".*textDocument/signatureHelp.*"),
  notnmsg(".*WinResized Autocommands.*"),

  notnmsg(".*W*%s*%[1/1%].*"),

  notnmsg(".*nvim_opts%.lua.*", "echo"),
  notnmsg(".*nvim_opts%.lua.*", "echomsg"),

  notnmsg(".*%[ddc%] Not found source.*", "echo"),
  notnmsg(".*%[ddc%] Not found source.*", "echomsg"),
  notnmsg(".*%[ddc%] Not found source.*", "emsg"),

  notnmsg("^No code actions available$", "notify"),
  notnmsg("^No information available$", "notify"),
  notnmsg(".*LSP.*"),
  notnmsg(".*nvim_opts%.lua.*", "lua_error"),

  --nmsg("^LSP%sstarted:.*", "notify"),
  --nmsg("^LSP%sstarted.*"),
  --nmsg("^LSP%sstarted.*", "notify"),
  --nmsg("LSP started", "notify"),
  --nmsg(".*LSP started.*"),
  --nmsg("^LSP%sstarted.*", "echo"),
  --nmsg("^LSP%sstarted.*", "echomsg"),
  --nmsg("^LSP%sstarted.*", "emsg"),
  --nmsg("^LSP started.*", "notify"),
  --nmsg("^LSP started.*", "echo"),
  --nmsg("^LSP started.*", "echomsg"),
  --nmsg("^LSP started.*", "emsg"),
}

local suppressLsps = {
  notnlsp(".*textDocument/hover.*"),
  notnlsp(".*textDocument/formatting.*"),
  notnlsp(".*textDocument/publishDiagnostics.*"),
  notnlsp(".*textDocument/signatureHelp.*"),
  notnlsp("WinResized Autocommands"),
  notnlsp(".*LSP.*"),
  --nlsp(".*LSP started.*"),
  --nlsp("LSP started"),
}

local suppressNotifies = {
  notnnotify(".*textDocument/hover.*"),
  notnnotify(".*textDocument/formatting.*"),
  notnnotify(".*textDocument/publishDiagnostics.*"),
  notnnotify(".*textDocument/signatureHelp.*"),
  notnnotify("WinResized Autocommands"),
  notnnotify("^%[ddc%] Not found source"),
  notnnotify("nvim_opts%.lua"),
  notnnotify(".*LSP.*"),
  --nnotify("LSP started"),
  --nnotify(".*LSP started.*"),
}

local suppressNoices = {
  notnnoice(".*textDocument/hover.*"),
  notnnoice(".*textDocument/formatting.*"),
  notnnoice(".*textDocument/publishDiagnostics.*"),
  notnnoice(".*textDocument/signatureHelp.*"),
  notnnoice("WinResized Autocommands"),
  notnnoice("^%[ddc%] Not found source"),
  notnnoice("nvim_opts%.lua"),
  notnnoice(".*LSP.*"),
  --nnoice("LSP started"),
  --nnoice(".*LSP started.*"),
}

local miniMessages = {
  nmsg("%d+L, %d+B"),
  nmsg("^%d+ changes?; after #%d+"),
  nmsg("^%d+ changes?; before #%d+"),
  nmsg("^Hunk %d+ of %d+$"),
  nmsg("^%d+ fewer lines;?"),
  nmsg("^%d+ more lines?;?"),
  nmsg("^%d+ line less;?"),
  nmsg("^Already at newest change"),
  nmsg(".*modifiable.*"),
  nmsg(".*Pick a window.*"),

  nmsg(".*%[denops%].*"),
  nmsg(".*%[hlchunk%.chunk%].*"),
  nmsg(".*%[lspconfig%].*"),

  nmsg("E486", "emsg"),
  nmsg(".*W*%s*%[1/1%].*", "search_count"),

  nmsg(".*Pick%sa%swindow.*", "echo"),
  nmsg("winpick", "echo"),
  nmsg(".*Pick%sa%swindow.*", "echomsg"),
  nmsg("winpick", "echomsg"),
  nmsg(".*LSP.*"),

  nmsg("", "wmsg"),
  nmsg("", "quickfix"),
  nmsg("", "quickfix"),
  nmsg("", "winpick"),

  --nmsg("LSP started"),
  --nmsg(".*LSP started.*"),
}

local miniLsps = {
  nlsp(".*%[lspconfig%].*"),
  nlsp(".*%[hlchunk%.chunk%].*"),
}

local miniNotifies = {
  nnotify(".*%[denops%].*"),
  nnotify(".*%[hlchunk%.chunk%].*"),
  nnotify(".*%[lspconfig%].*"),
}

--local routes = {}
--for _, v in pairs(suppressMessages) do
--  table.insert(routes, v)
--end
--for _, v in pairs(miniMessages) do
--  table.insert(routes, v)
--end

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

--function M.setup(noice) end

return M
