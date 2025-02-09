local utils = require('utils')

local M = {}

local g = vim.g
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

function M.setup()
  if vim.fn.has('wsl') or vim.fn.has('linux') then
    M.py()
    M.node()
  end
end

function M.py()
  local pypath = g.my_home_preference_path .. '/python.lua'
  -- python path
  if not utils.fs.exists(pypath) then
      -- TODO: PLZ TEST ME!!
      local py2path = vim.cmd("silent !which python")
      local py3path = vim.cmd("silent !which python3")
      local py2pref = "vim.g.python2_host_prog = " .. py2path
      local py3pref = "vim.g.python3_host_prog = " .. py3path

    local body = py2pref .. "\n" .. py3pref .. "\n"

    utils.io.debug_echo('python preference path' .. pypath)
    utils.io.debug_echo('python preference body' .. body)

    io.open(pypath, "w"):write(body):close()

    g.python2_host_prog = py2path
    g.python3_host_prog = py3path
  end
end

function M.node()
  local nodepath = g.my_home_preference_path .. '/node.lua'
  -- node path
  if not utils.fs.exists(nodepath) then
    local path = vim.cmd("silent !which node")
    local pref = "vim.g.node_host_prog = " .. path

    local body = pref .. "\n"

    utils.io.debug_echo('node preference path' .. path)
    utils.io.debug_echo('node preference body' .. body)

    io.open(nodepath, "w"):write(body):close()
    g.node_host_prog = path
  end
end

return M

