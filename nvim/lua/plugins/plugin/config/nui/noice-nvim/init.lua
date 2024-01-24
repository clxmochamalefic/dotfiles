local function suppressMessage(pattern, kind)
  kind = kind or ""
  return {
    view = "mini",
    filter = {
      event = "msg_show",
      kind = kind,
      find = pattern,
    },
    opts = { skip = true },
  }
end
local function suppressLsp(pattern, kind)
  kind = kind or ""
  return {
    view = "mini",
    filter = {
      event = "lsp",
      kind = kind,
      find = pattern,
    },
    opts = { skip = true },
  }
end
local function miniMessage(pattern, kind)
  kind = kind or ""
  return {
    view = "mini",
    filter = {
      event = "msg_show",
      kind = kind,
      find = pattern,
    },
  }
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
  suppressLsp(".*textDocument/hover.*"),
  suppressLsp(".*textDocument/formatting.*"),
  suppressLsp(".*textDocument/publishDiagnostics.*"),
  suppressLsp(".*textDocument/signatureHelp.*"),
  suppressLsp(".*WinResized Autocommands.*"),

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
  suppressLsp("^LSP%sstarted.*"),
  suppressLsp("^LSP%sstarted.*", "notify"),
  suppressLsp("^LSP%sstarted.*", "echo"),
  suppressLsp("^LSP%sstarted.*", "echomsg"),
  suppressLsp("^LSP%sstarted.*", "emsg"),
  --suppressMessage("^LSP started.*", "notify"),
  --suppressMessage("^LSP started.*", "echo"),
  --suppressMessage("^LSP started.*", "echomsg"),
  --suppressMessage("^LSP started.*", "emsg"),
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

  { kind = "wmsg", view = "mini" },
  { kind = "quickfix", view = "mini" },
  { kind = "winpick", view = "mini" },
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
    filter = routes,
  },
}

function M.setup(noice) end

return M
