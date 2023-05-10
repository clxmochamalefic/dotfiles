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

