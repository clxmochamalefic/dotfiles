local g = vim.g
local fn = vim.fn
local api = vim.api
local keymap = vim.keymap

local utils = require("utils")
local km_opts = require("const.keymap")
local ddu = require("plugins.rc.ui.config.ddu.core")
local filerUtils = require("plugins.rc.ui.config.ddu.ui.filer.utils")

local M = {
  util = filerUtils,
}

function M.setup()
  utils.io.begin_debug("ddu filer")

  local ddu_filer_source_columns = {
    "file_buf_modified",
    "devicon_filename",
    "file_git_status",
    --"icon_filename",
  }
  local ddu_filer_sources = {
    {
      name = "file",
      --param = {},
      options = {
        --sorters = { "sorter_alpha", "sorter_reversed" },
        columns = ddu_filer_source_columns,
      }
    },
  }
  local ddu_filer_source_options = {
    ["_"] = {
      columns = ddu_filer_source_columns,
    },
  }
  local ddu_filer_kind_options = {
    file = {
      defaultAction = "open",
    },
  }
  local ddu_filer_action_options = {
    narrow = {
      quit = false,
    },
  }

  local ddu_ui_filer_params = ddu.uiParamsVertical
  ddu_ui_filer_params.border = ddu.floatWindow.border
  ddu_ui_filer_params.search = fn.expand("%:p")
  ddu_ui_filer_params.sort = "filename"
  ddu_ui_filer_params.sortTreesFirst = true
  ddu_ui_filer_params.splitDirection = "topleft"

  local ddu_filer_uiparams = {
    ["_"] = ddu_ui_filer_params,
    filer = ddu_ui_filer_params,
    icon_filename = {
      span = 2,
      padding = 2,
      iconWidth = 2,
      useLinkIcon = "grayout",
      sort = "filename",
      sortTreesFirst = true,
    },
    devicon_filename = {
      iconWidth = 2,
      linkIcon = "grayout",
    },
    file_git_status = {
    },
    file_buf_modified = {
    },
  }

  for _, name in ipairs(filerUtils.filers) do
    ddu.patch_local(name, {
      ui = "filer",
      name = name,
      sources = ddu_filer_sources,
      resume = true,
      sourceOptions = ddu_filer_source_options,
      kindOptions = ddu_filer_kind_options,
      actionOptions = ddu_filer_action_options,
      uiParams = ddu_filer_uiparams,
    })
    -- ddu.push(name)
  end

  local function ddu_filer_my_settings()
    utils.io.begin_debug("ddu_filer_my_settings")

    ddu.action("kind", "file", "open_filer1", function()
      return filerUtils.open(1)
    end)
    ddu.action("kind", "file", "open_filer2", function()
      return filerUtils.open(2)
    end)
    ddu.action("kind", "file", "open_filer3", function()
      return filerUtils.open(3)
    end)
    ddu.action("kind", "file", "open_filer4", function()
      return filerUtils.open(4)
    end)

    utils.io.debug_echo("basic keymaps")
    -- basic actions
    keymap.set("n", "q", function()
      ddu.do_action("quit")
    end, km_opts.bn)
    -- TODO: redraw
    -- nnoremap <buffer><silent> R     <ll ddu#ui#filer#do_action('refreshItems')<Bar>redraw<CR>
    keymap.set("n", "R", function()
      ddu.do_action("refreshItems")
    end, km_opts.bn)
    keymap.set("n", "a", function()
      ddu.do_action("chooseAction")
    end, km_opts.bn)
    keymap.set("n", "P", function()
      ddu.do_action("preview")
    end, km_opts.bn)

    -- change window
    keymap.set("n", "<F5>", function()
      ddu.do_action("itemAction", { name = "open_filer1", params = { id = 0 }, quit = true })
    end, km_opts.bn)
    keymap.set("n", "<F6>", function()
      ddu.do_action("itemAction", { name = "open_filer2", params = { id = 1 }, quit = true })
    end, km_opts.bn)
    keymap.set("n", "<F7>", function()
      ddu.do_action("itemAction", { name = "open_filer3", params = { id = 2 }, quit = true })
    end, km_opts.bn)
    keymap.set("n", "<F8>", function()
      ddu.do_action("itemAction", { name = "open_filer4", params = { id = 3 }, quit = true })
    end, km_opts.bn)

    utils.io.debug_echo("change dir keymaps")
    -- change directory (path)
    keymap.set("n", "<CR>", function()
      return ddu.item.is_tree() and ddu.do_action("itemAction", { name = "narrow" })
          or ddu.do_action("itemAction", { name = "filer_window_choose", quit = true })
    end, km_opts.bn)
    keymap.set("n", "h", function()
      return ddu.item.is_tree() and ddu.do_action("collapseItem")
    end, km_opts.bn)
    --    keymap.set("n", "h",    function() return ddu.item.is_tree() and ddu.do_action('collapseItem')                   or utils.io.echoe('cannot close this item')                                            end, km_opts.bn)
    --    keymap.set("n", "l", function()
    --      return ddu.item.is_tree() and ddu.do_action("expandItem", { mode = "toggle" })
    --      or ddu.do_action("itemAction", { name = "open", params = { command = "vsplit" } })
    --    end, km_opts.bn)
    --    keymap.set("n", "L", function()
    --      return ddu.item.is_tree() and ddu.do_action("expandItem", { mode = "toggle" })
    --      or ddu.do_action("itemAction", { name = "open", params = { command = "split" } })
    --    end, km_opts.bn)
    keymap.set("n", "l", function()
      return ddu.item.is_tree() and ddu.do_action("expandItem")
          or ddu.do_action("itemAction", { name = "open", params = { command = "vsplit" } })
    end, km_opts.bn)
    keymap.set("n", "L", function()
      return ddu.item.is_tree() and ddu.do_action("expandItem")
          or ddu.do_action("itemAction", { name = "open", params = { command = "split" } })
    end, km_opts.bn)

    utils.io.debug_echo("change dir alias keymaps")
    -- change directory aliases
    keymap.set("n", "^", function()
      ddu.do_action("itemAction", { name = "narrow", params = { path = fn.expand(g.my_initvim_path) } })
    end, km_opts.bn)
    keymap.set("n", "\\", function()
      ddu.do_action("itemAction", { name = "narrow", params = { path = fn.expand("~/repos") } })
    end, km_opts.bn)
    keymap.set("n", "|", function()
      ddu.do_action("itemAction", { name = "narrow", params = { path = fn.expand("~/repos") } })
    end, km_opts.bn)
    keymap.set("n", "~", function()
      ddu.do_action("itemAction", { name = "narrow", params = { path = fn.expand("~") } })
    end, km_opts.bn)
    keymap.set("n", "=", function()
      ddu.do_action("itemAction", { name = "narrow", params = { path = fn.expand("~/Documents") } })
    end, km_opts.bn)
    keymap.set("n", "<BS>", function()
      ddu.do_action("itemAction", { name = "narrow", params = { path = ".." } })
    end, km_opts.bn)
    keymap.set("n", "C", function()
      ddu.do_action("itemAction", { name = "cd" })
    end, km_opts.bn)
    keymap.set("n", "c", function()
      ddu.do_action("itemAction", { name = "copy" })
    end, km_opts.bn)
    keymap.set("n", "x", function()
      ddu.do_action("itemAction", { name = "cut" })
    end, km_opts.bn)
    keymap.set("n", "p", function()
      ddu.do_action("itemAction", { name = "paste" })
    end, km_opts.bn)
    keymap.set("n", "m", function()
      ddu.do_action("itemAction", { name = "move" })
    end, km_opts.bn)
    keymap.set("n", "b", function()
      ddu.do_action("itemAction", { name = "newFile" })
    end, km_opts.bn)
    keymap.set("n", "B", function()
      ddu.do_action("itemAction", { name = "newDirectory" })
    end, km_opts.bn)
    keymap.set("n", "y", function()
      ddu.do_action("itemAction", { name = "yank" })
    end, km_opts.bn)
    keymap.set("n", "d", function()
      ddu.do_action("itemAction", { name = "delete" })
    end, km_opts.bn)
    keymap.set("n", "r", function()
      ddu.do_action("itemAction", { name = "rename" })
    end, km_opts.bns)

    utils.io.end_debug("ddu_filer_my_settings")
  end

  ddu.action("kind", "file", "filer_window_choose", function(args)
    return ddu.window_choose(args)
  end)

  local augroup_id = api.nvim_create_augroup("my_ddu_filer_preference", { clear = true })
  -- api.nvim_create_autocmd({ "TabEnter", "WinEnter", "CursorHold", "FocusGained" }, {
  --   group = augroup_id,
  --   pattern = "*",
  --   callback = function()
  --     ddu.do_action("checkItems")
  --   end,
  -- })
  api.nvim_create_autocmd("FileType", {
    group = augroup_id,
    pattern = { "ddu-filer" },
    callback = function()
      ddu_filer_my_settings()
    end,
  })

  utils.io.end_debug("ddu filer")
end

return M
