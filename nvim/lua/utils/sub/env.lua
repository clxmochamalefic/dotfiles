local fn = vim.fn

local M = {}

function M.is_pure_linux()
  return fn.has('linux') and not fn.has('wsl')
end

function M.is_wsl_linux()
  return fn.has('linux') and fn.has('wsl')
end

function M.is_linux()
  return fn.has('linux')
end

function M.is_mac_os()
  return fn.has('mac')
end

function M.is_pure_unix()
  return fn.has('unix') and not fn.has('mac')
end

function M.is_unix()
  return fn.has('unix')
end

function M.is_wsl()
  return fn.has('wsl')
end

function M.is_windows()
  return vim.fn.has('win32')
end

function M.get_path_splitter_for_current_env()
  if M.is_linux() or M.is_unix() then
    return '/'
  end

  return '\\'
end

return M
