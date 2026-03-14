local io = require("utils.io")

-- 疑似trycatch
local function try_catch(what)
  io.debug_echo("begin try --->")
  local status, exception = pcall(what.try)
  if not status then
    io.debug_echo("#### begin catch --->")
    what.catch(exception)
    io.debug_echo("<--- end catch ####")
  else
    io.debug_echo("<--- end try")
  end
  if what.finally then
    io.debug_echo("begin finally --->")
    what.finally()
    io.debug_echo("<--- end finally")
  end

  return exception
end

return try_catch
