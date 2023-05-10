-- debug preference
function _G.DebugEcho(mes)
  if vim.g.is_enable_my_debug then
    vim.fn.echo("begin " + mes + " load")
  end
end

function _G.FileExists(name)
   local f = io.open(name, "r")
   return f ~= nil and io.close(f)
end

function _G.TryCatch(what)
  local status, exception = pcall(what.try)
  if not status then
    what.catch(exception)
  end
  if what.finally then
    what.finally()
  end
  return exception
end
