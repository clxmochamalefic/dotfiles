local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local utils = require("utils")
local km_opts = require("const.keymap")
local ddu = require("plugins.plugin.config.ddu.core")

local M = {
  current_ff_name = "buffer"
}

-- ddu-ui-ff
function M.show()
  utils.io.begin_debug("show_ddu_ff")

  utils.io.echom("ddu-ff: " .. M.current_ff_name)
  ddu.start({ name = M.current_ff_name })

  utils.io.end_debug("show_ddu_ff")
  return 0
end

function M.open(name)
  M.current_ff_name = name
  return M.show()
end

return M

