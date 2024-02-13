local noice = {}

function noice.notify_wrapper(pattern, kind, event)
  kind = kind or ""
  event = event or "msg_show"

  return {
    event = event,
    kind = kind,
    find = pattern,
  }
end

function noice.notify_not(pattern, kind, event)
  return { ["not"] = noice.notify_wrapper(pattern, kind, event) }
end

function noice.not_msg(pattern, kind)
  return noice.notify_not(pattern, kind, "msg_show")
end

function noice.not_lsp(pattern, kind)
  return noice.notify_not(pattern, kind, "lsp")
end

function noice.not_notify(pattern, kind)
  return noice.notify_not(pattern, kind, "notify")
end

function noice.not_noice(pattern, kind)
  return noice.notify_not(pattern, kind, "noice")
end

function noice.not_popup(pattern, kind)
  return noice.notify_not(pattern, kind, "popup")
end

function noice.not_quickfix(pattern, kind)
  return noice.notify_not(pattern, kind, "quickfix")
end

function noice.msg(pattern, kind)
  return noice.notify_wrapper(pattern, kind, "msg_show")
end

function noice.lsp(pattern, kind)
  return noice.notify_wrapper(pattern, kind, "lsp")
end

function noice.notify(pattern, kind)
  return noice.notify_wrapper(pattern, kind, "notify")
end

function noice.noice(pattern, kind)
  return noice.notify_wrapper(pattern, kind, "noice")
end

function noice.popup(pattern, kind)
  return noice.notify_wrapper(pattern, kind, "popup")
end

function noice.quickfix(pattern, kind)
  return noice.notify_wrapper(pattern, kind, "quickfix")
end

local M = {
  noice = noice,
}

return M
