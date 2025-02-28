local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local utils = require("utils")
local km_opts = require("const.keymap")
local ddu = require("plugins.rc.config.ddu.core")

local M = {
  current_filer = 1,
  filers = { "filer_1", "filer_2", "filer_3", "filer_4" },
}

M.show = function ()
  utils.io.begin_debug("show_ddu_filer")

  utils.io.echom("ddu-filer: " .. M.filers[M.current_filer])
  ddu.start({ name = M.filers[M.current_filer] })

  utils.io.end_debug("show_ddu_filer")
  return 0
end

M.open = function (window_id)
  M.current_filer = window_id
  return M.show()
end

return M
