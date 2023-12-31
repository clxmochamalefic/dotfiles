local fn = vim.fn

local M = {}

function M.is_pure_linux()
  return fn.has('linux') == 1 and fn.has('wsl') == 0
end

function M.is_wsl_linux()
  return fn.has('linux') == 1 and fn.has('wsl') == 1
end

function M.is_linux()
  return fn.has('linux') == 1
end

function M.is_mac_os()
  return fn.has('mac') == 1
end

function M.is_pure_unix()
  return fn.has('unix') == 1 and fn.has('mac') == 0
end

function M.is_unix()
  return fn.has('unix') == 1
end

function M.is_posix()
  return M.is_unix() or M.is_linux()
end

function M.is_wsl()
  return fn.has('wsl') == 1
end

function M.is_windows()
  return fn.has('win32') == 1
end

function M.get_path_splitter_for_current_env()
  if M.is_linux() or M.is_unix() then
    return '/'
  end

  return '\\'
end
function M.join_path_with_separator(separator, ...)
  local args = {}
  for i = 1, select("#", ...) do
    local arg = (select(i, ...))
    args[i] = arg
  end
  local path = table.concat(args, separator)
  return path
end

function M.join_path(...)
  local separator = M.get_path_splitter_for_current_env()
  return M.join_path_with_separator(separator, ...)
end

function M.join_path_slash(...)
  return M.join_path_with_separator('/', ...)
end

function M.getHome()
  if M.is_windows() then
    return os.getenv("UserProfile")
  end
  return os.getenv("HOME")
end

function M.test()
  print(M.join_path(M.getHome(), ".lib", "sqlite"))
end

return M
