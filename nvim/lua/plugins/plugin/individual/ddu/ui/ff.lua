local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local utils = require("utils")
local km_opts = require("const.keymap")
local ddu = require("plugins.plugin.individual.ddu.ui.util")

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

function M.setup()
  utils.io.begin_debug("ddu ff")

  ddu.action("kind", "file", "ff_window_choose", function(args)
    ddu.window_choose(args)
  end)
  ddu.action("kind", "word", "ff_window_choose", function(args)
    ddu.window_choose(args)
  end)

  ddu.action("kind", "file", "ff_open_buffer", function()
    return open_ddu_ff("buffer")
  end)
  ddu.action("kind", "file", "ff_open_mrw", function()
    return open_ddu_ff("mrw")
  end)
  ddu.action("kind", "file", "ff_open_mrw_current", function()
    return open_ddu_ff("mrw_current")
  end)
  ddu.action("kind", "file", "ff_open_emoji", function()
    return open_ddu_ff("emoji")
  end)

  ddu.action("kind", "word", "ff_open_buffer", function()
    return open_ddu_ff("buffer")
  end)
  ddu.action("kind", "word", "ff_open_mrw", function()
    return open_ddu_ff("mrw")
  end)
  ddu.action("kind", "word", "ff_open_mrw_current", function()
    return open_ddu_ff("mrw_current")
  end)
  ddu.action("kind", "word", "ff_open_emoji", function()
    return open_ddu_ff("emoji")
  end)

  if fn.has("win32") then
    ddu.action("kind", "file", "ff_open_clip_history", function()
      return open_ddu_ff("clip_history")
    end)
    ddu.action("kind", "word", "ff_open_clip_history", function()
      return open_ddu_ff("clip_history")
    end)
  end

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
    open_ddu_ff("buffer")
  end, {})

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
    open_ddu_ff("file_old")
  end, {})

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
    open_ddu_ff("emoji")
  end, {})

  --  ddu-source-mrw
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
    open_ddu_ff("mrw")
  end, {})

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
    open_ddu_ff("mrw_current")
  end, {})

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
      open_ddu_ff("clip_history")
    end, {})
  end

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
