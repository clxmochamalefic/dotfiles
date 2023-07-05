local utils = require('utils')

local path = {}

local g = vim.g
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

function path.setup()
  path.py()
  path.node()
end

function path.py()
  local pypath = g.my_home_preference_path .. '/python.lua'
  -- python path
  if not utils.file_exists(pypath) then
    local py2path = ""
    local py3path = ""
    local py2pref = ""
    local py3pref = ""

    if vim.fn.has('win32') then
      local py3path = vim.cmd("!gcm python | Select-Object Source")
      local py3pref = "vim.g.python3_host_prog = " .. py3path

    elseif vim.fn.has('mac') then
      -- TODO: PLZ TEST ME!!
      local py2path = "$PYENV_ROOT.'/versions/neovim2/bin/python'"
      local py3path = "$PYENV_ROOT.'/versions/neovim3/bin/python'"
      local py2pref = "vim.g.python2_host_prog = " .. py2path
      local py3pref = "vim.g.python3_host_prog = " .. py3path

    else
      -- TODO: PLZ TEST ME!!
      local path = vim.cmd("!which node")

    end

    local body = py2pref .. "\n" .. py3pref .. "\n"

    utils.debug_echo('python preference path' .. pypath)
    utils.debug_echo('python preference body' .. body)

    io.open(pypath, "w"):write(body):close()

    g.python2_host_prog = py2path
    g.python3_host_prog = py3path
  end
end

function path.node()
  local nodepath = g.my_home_preference_path .. '/node.lua'
  -- node path
  if not utils.file_exists(nodepath) then
    local path = ""

    if vim.fn.has('win32') then
      local path = vim.cmd("!gcm node | Select-Object Source")
      local pref = "vim.g.node_host_prog = " .. path

    elseif vim.fn.has('mac') then
      -- TODO: PLZ TEST ME!!
      local path = vim.cmd("!which node")

    else
      -- TODO: PLZ TEST ME!!
      local path = vim.cmd("!which node")

    end

    local pref = "vim.g.node_host_prog = " .. path

    local body = pref .. "\n"

    utils.debug_echo('node preference path' .. path)
    utils.debug_echo('node preference body' .. body)

    io.open(nodepath, "w"):write(body):close()
    g.node_host_prog = path
  end
end

return path

