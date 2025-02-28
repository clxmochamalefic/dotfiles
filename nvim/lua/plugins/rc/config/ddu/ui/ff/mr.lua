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

function M.mrw()
  local mr_source = {
    name = "mr",
    param = { kind = "mrw" },
  }

  ddu.patch_local("mrw", {
    ui = "ff",
    sources = {
      mr_source,
    },
    kindOptions = {
      mrw = {
        defaultAction = "open",
      },
    },
    uiParams = {
      ["_"] = ddu.uiParams,
      mr = ddu.uiParams,
    },
  })

  api.nvim_create_user_command("DduMrw", function()
    ffutils.open("mrw")
  end, {})
end

function M.mrwCurrent()
  local mrw_source = {
    name = "mr",
    param = { kind = "mrw", current = true },
  }
  ddu.patch_local("mrw_current", {
    ui = "ff",
    sources = {
      mrw_source,
    },
    kindOptions = {
      mrw = {
        defaultAction = "open",
      },
    },
    uiParams = {
      ["_"] = ddu.uiParams,
      mrw = ddu.uiParams,
    },
  })

  api.nvim_create_user_command("DduMrwCurrent", function()
    ffutils.open("mrw_current")
  end, {})
end

function M.setup()
  M.mrw()
  M.mrwCurrent()
end

return M

