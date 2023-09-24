local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local utils = require("utils")
local km_opts = require("const.keymap")
local ddu = require("plugins.plugin.individual.ddu.core")
local ffutils = require("plugins.plugin.individual.ddu.ui.ff.utils")

local M = {}

function M.setup()
  --  ddu-source-buffer
  ddu.patch_local("buffer", {
    ui = "ff",
    sources = {
      {
        name = "buffer",
        param = { path = "~" },
      },
    },
    kindOptions = {
      buffer = {
        defaultAction = "open",
      },
    },
    uiParams = {
      ["_"] = ddu.uiParams,
      buffer = ddu.uiParams,
    },
  })

  api.nvim_create_user_command("DduBuffer", function()
    ffutils.open("buffer")
  end, {})
end

return M
