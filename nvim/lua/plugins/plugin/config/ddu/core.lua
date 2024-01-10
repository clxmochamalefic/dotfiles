local utils = require("utils")

local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local km_opts = require("const.keymap")

local M = {
  patch_global = fn["ddu#custom#patch_global"],
  action = fn["ddu#custom#action"],
  start = fn["ddu#start"],
  sync_action = fn["ddu#ui#sync_action"],
  do_action = fn["ddu#ui#do_action"],
  patch_local = fn["ddu#custom#patch_local"],
  item = {
    is_tree = function()
      return fn["ddu#ui#get_item"]()["isTree"]
    end,
  },
}

M.floatWindow = {
  col = g.float_window_col,
  row = g.float_window_row,
  width = g.float_window_width,
  height = g.float_window_height,
  preview_width = 120,
  preview_col = 0,
  preview_height = g.ddu_float_window_height,
  border = "rounded",
  split = "floating",
}

M.uiParams = {
  span = 2,

  split = M.floatWindow.split,
  floatingBorder = M.floatWindow.border,
  filterFloatingPosition = "bottom",
  filterSplitDirection = M.floatWindow.split,
  winRow = M.floatWindow.row,
  winCol = M.floatWindow.col,
  winWidth = M.floatWindow.width,
  winHeight = M.floatWindow.height,

  previewFloating = true,
  previewVertical = true,
  previewFloatingBorder = M.floatWindow.border,
  previewFloatingZindex = 10000,
  previewCol = M.floatWindow.preview_col,
  previewWidth = M.floatWindow.preview_width,
  previewHeight = M.floatWindow.preview_height,
}

function M.win_all()
  return fn.range(1, fn.winnr("$"))
end

function M.win_count()
  return fn.winnr("$")
end

function M.window_choose(args)
  utils.io.begin_debug("window_choose")
  utils.io.debug_echo("args", args)


  utils.try_catch({
    try = function()
      local path = args.items[1].action.path
      if M.win_count() <= 1 then
        vim.cmd("edit " .. path)
        return
      end

      local my_winpick = require("plugins.plugin.config.winpick")
      my_winpick.choose_for_focus()
      vim.cmd("edit " .. path)
    end,
    catch = function()
      M.do_action("itemAction", args)
    end,
  })
  utils.io.end_debug("window_choose")
  return 0
end

return M
