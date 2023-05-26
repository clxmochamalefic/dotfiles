local g = vim.g
local keymap = vim.keymap
local api = vim.api

local M = {}

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
  M._echo("err", mes)
end

-- debug preference
function M.debug_echo(mes, args, stack)
  if g.is_enable_my_debug then
    M.echom(mes)
    local this_stack = stack or 0

    local tabshift = ""
    for i=0,this_stack do
      tabshift = tabshift .. "  "
    end

    if args then
      if type(args) ~= "table" then
        M.echom(tabshift .. " : " .. args)
        return
      end
      for i, v in ipairs(args) do
        if type(v) == "table" then
          M.debug_echo(i, v, this_stack + 1)
        else
          M.echom(tabshift .. i .. " : " .. v)
        end
      end
    end
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
  M.debug_echo("begin try --->")
  local status, exception = pcall(what.try)
  if not status then
    M.debug_echo("#### begin catch --->")
    what.catch(exception)
    M.debug_echo("<--- end catch ####")
  else
    M.debug_echo("<--- end try")
  end
  if what.finally then
    M.debug_echo("begin finally --->")
    what.finally()
    M.debug_echo("<--- end finally")
  end

  return exception
end

function M.get_vim_lines()
  return api.nvim_eval("&lines")
end

function M.get_vim_columns()
  return api.nvim_eval("&columns")
end

function M.resize_float_window_default()
  M.resize_float_window(8, 30)
end
function M.resize_float_window(col, height)
  g.float_window_col    = col
  g.float_window_height = height
  g.float_window_row    = M.get_vim_lines()   - g.float_window_height - 2
  g.float_window_width  = M.get_vim_columns() - (g.float_window_col * 2)
end

function M.feedkey(key, mode)
	api.nvim_feedkeys(api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

function M.keymap_set(t)
  local mode  = t.mode
  local lhs   = t.lhs
  local rhs   = t.rhs
  local opts  = t.opts

  if type(mode) ~= "table" then
    mode = { t.mode }
  end

  for _, m in ipairs(mode) do
    keymap.set(m, lhs, rhs, opts)
  end
end

return M

