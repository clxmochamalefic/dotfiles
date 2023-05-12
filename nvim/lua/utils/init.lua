-- debug preference
return {
  DebugEcho = function(mes)
    if vim.g.is_enable_my_debug then
      vim.fn.echo("begin " + mes + " load")
    end
  end,
  
  FileExists = function(name)
    local f = io.open(name, "r")
    return f ~= nil and io.close(f)
  end,
  
  TryCatch = function(what)
    local status, exception = pcall(what.try)
    if not status then
      what.catch(exception)
    end
    if what.finally then
      what.finally()
    end

    return exception
  end
}
