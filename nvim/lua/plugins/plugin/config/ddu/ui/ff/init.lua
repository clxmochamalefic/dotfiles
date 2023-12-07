local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local utils   = require("utils")
local km_opts = require("const.keymap")
local ddu     = require("plugins.plugin.config.ddu.core")
local ffutils = require("plugins.plugin.config.ddu.ui.ff.utils")


local buffer  = require("plugins.plugin.config.ddu.ui.ff.buffer")
local clip    = require("plugins.plugin.config.ddu.ui.ff.clip")
local emoji   = require("plugins.plugin.config.ddu.ui.ff.emoji")
local file    = require("plugins.plugin.config.ddu.ui.ff.file")
local lsp     = require("plugins.plugin.config.ddu.ui.ff.lsp")
local mr      = require("plugins.plugin.config.ddu.ui.ff.mr")

local M = {
  util = ffutils
}

function M.setKindActions()
  ddu.action("kind", "file", "ff_window_choose", function(args)
    ddu.window_choose(args)
  end)
  ddu.action("kind", "word", "ff_window_choose", function(args)
    ddu.window_choose(args)
  end)

  ddu.action("kind", "file", "ff_open_buffer", function()
    return ffutils.open("buffer")
  end)
  ddu.action("kind", "file", "ff_open_mrw", function()
    return ffutils.open("mrw")
  end)
  ddu.action("kind", "file", "ff_open_mrw_current", function()
    return ffutils.open("mrw_current")
  end)
  ddu.action("kind", "file", "ff_open_emoji", function()
    return ffutils.open("emoji")
  end)

  ddu.action("kind", "word", "ff_open_buffer", function()
    return ffutils.open("buffer")
  end)
  ddu.action("kind", "word", "ff_open_mrw", function()
    return ffutils.open("mrw")
  end)
  ddu.action("kind", "word", "ff_open_mrw_current", function()
    return ffutils.open("mrw_current")
  end)
  ddu.action("kind", "word", "ff_open_emoji", function()
    return ffutils.open("emoji")
  end)

  if fn.has("win32") then
    ddu.action("kind", "file", "ff_open_clip_history", function()
      return ffutils.open("clip_history")
    end)
    ddu.action("kind", "word", "ff_open_clip_history", function()
      return ffutils.open("clip_history")
    end)
  end
end

function M.setup()
  utils.io.begin_debug("ddu ff")

  M.setKindActions()

  buffer.setup()
  clip.setup()
  emoji.setup()
  file.setup()
  lsp.setup()
  mr.setup()

  local function ddu_ff_my_settings()
    utils.io.begin_debug("ddu_ff_my_settings")

    keymap.set("n", "<F5>", function()
      ddu.do_action("itemAction", { name = "ff_open_buffer", quit = true })
    end, km_opts.bn)
    keymap.set("n", "<F6>", function()
      ddu.do_action("itemAction", { name = "ff_open_mrw", quit = true })
    end, km_opts.bn)
    keymap.set("n", "<F7>", function()
      ddu.do_action("itemAction", { name = "ff_open_mrw_current", quit = true })
    end, km_opts.bn)
    keymap.set("n", "<F8>", function()
      ddu.do_action("itemAction", { name = "ff_open_emoji", quit = true })
    end, km_opts.bn)

    if fn.has("win32") then
      keymap.set("n", "<F9>", function()
        ddu.do_action("itemAction", { name = "ff_open_clip_history", quit = true })
      end, km_opts.bn)
    end

    keymap.set("n", "<CR>", function()
      ddu.do_action("itemAction", { name = "ff_window_choose", quit = true })
    end, km_opts.bn)
    keymap.set("n", "<Space>", function()
      ddu.do_action("toggleSelectItem")
    end, km_opts.bn)
    keymap.set("n", "i", function()
      ddu.do_action("openFilterWindow")
    end, km_opts.bn)
    keymap.set("n", "P", function()
      ddu.do_action("preview")
    end, km_opts.bn)
    keymap.set("n", "q", function()
      ddu.do_action("quit")
    end, {})

    keymap.set("n", "l", function()
      ddu.do_action("itemAction", { name = "open", params = { command = "vsplit" }, quit = true })
    end, km_opts.bn)
    keymap.set("n", "L", function()
      ddu.do_action("itemAction", { name = "open", params = { command = "split" }, quit = true })
    end, km_opts.bn)

    keymap.set("n", "d", function()
      ddu.do_action("itemAction", { name = "delete" })
    end, km_opts.bn)

    utils.io.end_debug("ddu_ff_my_settings")
  end

  local augroup_id = api.nvim_create_augroup("my_ddu_ff_preference", { clear = true })
  api.nvim_create_autocmd("FileType", {
    group = augroup_id,
    pattern = { "ddu-ff" },
    callback = function ()
      ddu_ff_my_settings()
    end,
  })

  utils.io.end_debug("ddu ff")
end

return M
