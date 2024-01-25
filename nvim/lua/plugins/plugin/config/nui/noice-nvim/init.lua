local function noiceWrapper(pattern, kind, event, opts)
  kind = kind or ""
  opts = opts or {}
  return {
    view = "mini",
    filter = {
      event = event,
      kind = kind,
      find = pattern,
    },
    opts = opts,
  }
end
local function suppressMessage(pattern, kind)
  return noiceWrapper(pattern, kind, "msg_show", { skip = true })
  --kind = kind or ""
  --return {
  --  view = "mini",
  --  filter = {
  --    event = "msg_show",
  --    kind = kind,
  --    find = pattern,
  --  },
  --  opts = { skip = true },
  --}
end
local function suppressLsp(pattern, kind)
  return noiceWrapper(pattern, kind, "lsp", { skip = true })
  --kind = kind or ""
  --return {
  --  view = "mini",
  --  filter = {
  --    event = "lsp",
  --    kind = kind,
  --    find = pattern,
  --  },
  --  opts = { skip = true },
  --}
end
local function suppressNotify(pattern, kind)
  return noiceWrapper(pattern, kind, "notify", { skip = true })
  --kind = kind or ""
  --return {
  --  view = "mini",
  --  filter = {
  --    event = "notify",
  --    kind = kind,
  --    find = pattern,
  --  },
  --  opts = { skip = true },
  --}
end
local function miniMessage(pattern, kind)
  return noiceWrapper(pattern, kind, "msg_show")
  --kind = kind or ""
  --return {
  --  view = "mini",
  --  filter = {
  --    event = "msg_show",
  --    kind = kind,
  --    find = pattern,
  --  },
  --}
end
local function miniLsp(pattern, kind)
  return noiceWrapper(pattern, kind, "lsp")
  --kind = kind or ""
  --return {
  --  view = "mini",
  --  filter = {
  --    event = "lsp",
  --    kind = kind,
  --    find = pattern,
  --  },
  --}
end
local function miniNotify(pattern, kind)
  return noiceWrapper(pattern, kind, "notify")
  --kind = kind or ""
  --return {
  --  view = "mini",
  --  filter = {
  --    event = "notify",
  --    kind = kind,
  --    find = pattern,
  --  },
  --}
end

local suppressMessages = {
  suppressMessage("^%d+ lines .ed %d+ times?$"),
  suppressMessage("^%d+ lines yanked$"),
  suppressMessage(".*E490.*", "emsg"),
  suppressMessage("search_count"),

  suppressMessage(".*E539.*", "emsg"),
  suppressMessage(".*textDocument/hover.*"),
  suppressMessage(".*textDocument/formatting.*"),
  suppressMessage(".*textDocument/publishDiagnostics.*"),
  suppressMessage(".*textDocument/signatureHelp.*"),
  suppressMessage(".*WinResized Autocommands.*"),

  suppressMessage(".*W*%s*%[1/1%].*"),

  suppressMessage(".*nvim_opts%.lua.*", "echo"),
  suppressMessage(".*nvim_opts%.lua.*", "echomsg"),

  suppressMessage(".*%[ddc%] Not found source.*", "echo"),
  suppressMessage(".*%[ddc%] Not found source.*", "echomsg"),
  suppressMessage(".*%[ddc%] Not found source.*", "emsg"),

  suppressMessage("^No code actions available$", "notify"),
  suppressMessage("^No information available$", "notify"),
  suppressMessage("^LSP%sstarted:.*", "notify"),
  suppressMessage(".*nvim_opts%.lua.*", "lua_error"),

  suppressMessage("^LSP%sstarted.*"),
  suppressMessage("^LSP%sstarted.*", "notify"),
  suppressMessage("LSP started", "notify"),
  suppressMessage("^LSP%sstarted.*", "echo"),
  suppressMessage("^LSP%sstarted.*", "echomsg"),
  suppressMessage("^LSP%sstarted.*", "emsg"),
  --suppressMessage("^LSP started.*", "notify"),
  --suppressMessage("^LSP started.*", "echo"),
  --suppressMessage("^LSP started.*", "echomsg"),
  --suppressMessage("^LSP started.*", "emsg"),
}

local suppressLsps = {
  suppressLsp("textDocument/hover"),
  suppressLsp("textDocument/formatting"),
  suppressLsp("textDocument/publishDiagnostics"),
  suppressLsp("textDocument/signatureHelp"),
  suppressLsp("WinResized Autocommands"),
  suppressLsp("LSP started"),
}

local suppressNotifies = {
  suppressNotify("textDocument/hover"),
  suppressNotify("textDocument/formatting"),
  suppressNotify("textDocument/publishDiagnostics"),
  suppressNotify("textDocument/signatureHelp"),
  suppressNotify("WinResized Autocommands"),
  suppressNotify("%[ddc%] Not found source"),
  suppressNotify("nvim_opts%.lua"),
  suppressNotify("LSP started"),
}

local miniMessages = {
  miniMessage("%d+L, %d+B"),
  miniMessage("^%d+ changes?; after #%d+"),
  miniMessage("^%d+ changes?; before #%d+"),
  miniMessage("^Hunk %d+ of %d+$"),
  miniMessage("^%d+ fewer lines;?"),
  miniMessage("^%d+ more lines?;?"),
  miniMessage("^%d+ line less;?"),
  miniMessage("^Already at newest change"),
  miniMessage(".*modifiable.*"),
  miniMessage(".*Pick a window.*"),
  miniMessage("%[denops%]"),
  miniMessage("%[hlchunk%.chunk%]"),

  miniMessage("E486", "emsg"),
  miniMessage(".*W*%s*%[1/1%].*", "search_count"),

  miniMessage(".*Pick%sa%swindow.*", "echo"),
  miniMessage("%[hlchunk%.chunk%]", "echo"),
  miniMessage("winpick", "echo"),
  miniMessage(".*Pick%sa%swindow.*", "echomsg"),
  miniMessage("%[hlchunk%.chunk%]", "echomsg"),
  miniMessage("winpick", "echomsg"),
  miniMessage("%[hlchunk%.chunk%]", "notify"),
  miniMessage("LSP started"),

  { kind = "wmsg", view = "mini" },
  { kind = "quickfix", view = "mini" },
  { kind = "winpick", view = "mini" },
}

local miniLsps = {
  miniLsp("%[lspconfig%]"),
}

local miniNotifies = {
  miniNotify("%[denops%]"),
  miniNotify("%[hlchunk%.chunk%]"),
  miniNotify("%[lspconfig%]"),
}

local routes = {}
for _, v in pairs(suppressMessages) do
  table.insert(routes, v)
end
for _, v in pairs(miniMessages) do
  table.insert(routes, v)
end

--local M = {
--  routes = {
--    filter = routes,
--  },
--}
local M = {
  routes = {
    filter = {
      {
        event = "msg_show",
        any = suppressMessages,
        opts = { skip = true },
      },
      {
        event = "lsp",
        any = suppressLsps,
        opts = { skip = true },
      },
      {
        event = "notify",
        any = suppressNotifies,
        opts = { skip = true },
      },
      {
        event = "msg_show",
        any = miniMessages,
        view = "mini",
      },
      {
        event = "lsp",
        any = miniLsps,
        view = "mini",
      },
      {
        event = "notify",
        any = miniNotifies,
        view = "mini",
      },
    },
  },
  --routes = {
  --  {
  --    event = "msg_show",
  --    filter = {
  --      any = miniMessages,
  --      --view = "mini",
  --    },
  --    view = "mini",
  --  },
  --  --filter = {
  --  --  --event = "msg_show",
  --  --  any = miniMessages,
  --  --  --view = "mini",
  --  --},
  --  --view = "mini",
  --  --{
  --  --  filter = {
  --  --    event = "msg_show",
  --  --    suppressMessages,
  --  --  },
  --  --  opts = { skip = true },
  --  --},
  --},
}

--function M.setup(noice) end

return M
