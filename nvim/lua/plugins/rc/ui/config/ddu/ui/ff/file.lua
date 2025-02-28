local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local utils = require("utils")
local km_opts = require("const.keymap")
local ddu = require("plugins.rc.ui.config.ddu.core")
local ffutils = require("plugins.rc.ui.config.ddu.ui.ff.utils")

local M = {}

function M.setup()
  --  ddu-source-file_old
  ddu.patch_local("file_old", {
    ui = "ff",
    sources = {
      {
        name = "file_old",
        param = {},
      },
    },
    kindOptions = {
      file_old = {
        defaultAction = "open",
      },
    },
    uiParams = {
      ["_"] = ddu.uiParams,
      file_old = ddu.uiParams,
    },
  })

  api.nvim_create_user_command("DduFileOld", function()
    ffutils.open("file_old")
  end, {})
end

return M

