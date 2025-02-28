local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local utils = require("utils")
local km_opts = require("const.keymap")
local ddu = require("plugins.rc.config.ddu.core")
local ffutils = require("plugins.rc.config.ddu.ui.ff.utils")

local M = {}

function M.setup()
  --  windows-clipboard-history
  if fn.has("win32") then
    ddu.patch_local("clip_history", {
      ui = "ff",
      sources = {
        {
          name = "windows-clipboard-history",
          param = { prefix = "Clip:" },
        },
      },
      kindOptions = {
        clip_history = {
          defaultAction = "yank",
        },
      },
      uiParams = {
        ["_"] = ddu.uiParams,
        clip_history = ddu.uiParams,
      },
    })

    api.nvim_create_user_command("DduClip", function()
      ffutils.open("clip_history")
    end, {})
  end
end

return M

