local M = {}

function M.load(_collection)
end

function M._echo(type, mes)
  vim.cmd("echo" .. type .. " '" .. mes .. "'")
end

function M.echo( mes)
  M._echo("", mes)
end
function M.echom(mes)
  M._echo("m", mes)
end

function M.echoerr(mes)
  M._echo("err", mes)
end

function M.echoe(mes)
  M.echoerr(mes)
end

-- debug preference
function M.debug_echo(mes)
  if vim.g.is_enable_my_debug then
    M.echom(mes)
  end
end

function M.begin_debug(mes)
  M.debug_echo("begin " .. mes)
end
function M.end_debug(mes)
  M.debug_echo("end " .. mes)
end

function M.file_exists(name)
  local f = io.open(name, "r")
  return f ~= nil and io.close(f)
end

function M.try_catch(what)
  local status, exception = pcall(what.try)
  if not status then
    what.catch(exception)
  end
  if what.finally then
    what.finally()
  end

  return exception
end

function M.get_vim_lines()
  return vim.api.nvim_eval("&lines")
end

function M.get_vim_columns()
  return vim.api.nvim_eval("&columns")
end

function M.resize_float_window_default()
  M.resize_float_window(8, 30)
end
function M.resize_float_window(col, height)
  vim.g.float_window_col = col
  vim.g.float_window_height = height
  vim.g.float_window_row = M.get_vim_lines() - vim.g.float_window_height - 2
  vim.g.float_window_width = M.get_vim_columns() - (vim.g.float_window_col * 2)
end

return M

