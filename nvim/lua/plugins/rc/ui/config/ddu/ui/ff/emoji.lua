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
  --  ddu-source-emoji
  ddu.patch_local("emoji", {
    ui = "ff",
    sources = {
      {
        name = "emoji",
        param = {},
      },
    },
    kindOptions = {
      emoji = {
        defaultAction = "append",
      },
      word = {
        defaultAction = "append",
      },
    },
    uiParams = {
      ["_"] = ddu.uiParams,
      emoji = ddu.uiParams,
    },
  })

  api.nvim_create_user_command("DduEmoji", function()
    ffutils.open("emoji")
  end, {})
end

return M

