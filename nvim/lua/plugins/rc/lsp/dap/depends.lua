-- ---------------------------------------------------------------------------
-- DAP (debug adapter protocol) PLUGINS DEPENDENCIES
-- ---------------------------------------------------------------------------

local myutils = require("utils")

local M = {}

M.init = function()
  if not myutils.depends.has("gdb") then
    myutils.depends.install("gdb", {}, { myutils.env.is_windows })
  end
  if not myutils.depends.has("lldb") then
    myutils.depends.install("lldb", { winget = "LLVM.LLVM" })
  end
  if not myutils.depends.has("rr") then
    myutils.depends.install("rr", {}, { myutils.env.is_windows })
  end
end

return M
