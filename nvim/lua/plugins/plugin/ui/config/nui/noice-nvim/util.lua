local M = {}

function M.noiceWrapper(pattern, kind, event)
  kind = kind or ""
  event = event or "msg_show"

  return {
    event = event,
    kind = kind,
    find = pattern,
  }
end

function M.noiceNotWrapper(pattern, kind, event)
  return { ["not"] = M.noiceWrapper(pattern, kind, event) }
end

function M.notnmsg(pattern, kind)
  return M.noiceNotWrapper(pattern, kind, "msg_show")
end

function M.notnlsp(pattern, kind)
  return M.noiceNotWrapper(pattern, kind, "lsp")
end

function M.notnnotify(pattern, kind)
  return M.noiceNotWrapper(pattern, kind, "notify")
end

function M.notnnoice(pattern, kind)
  return M.noiceNotWrapper(pattern, kind, "noice")
end

function M.nmsg(pattern, kind)
  return M.noiceWrapper(pattern, kind, "msg_show")
end

function M.nlsp(pattern, kind)
  return M.noiceWrapper(pattern, kind, "lsp")
end

function M.nnotify(pattern, kind)
  return M.noiceWrapper(pattern, kind, "notify")
end

function M.nnoice(pattern, kind)
  return M.noiceWrapper(pattern, kind, "noice")
end

return M
