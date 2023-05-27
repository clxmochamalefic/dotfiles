local utils = require('utils')

local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local DDU_TYPE = { FF = 0, Filer = 1 }

local km_opts = require("const.keymap")

local ddu = {
  patch_global  = fn['ddu#custom#patch_global'],
  action        = fn['ddu#custom#action'],
  start         = fn['ddu#start'],
  ff = {
    do_action = fn["ddu#ui#ff#do_action"],
  },
  filer = {
    do_action = fn["ddu#ui#filer#do_action"],
  },
  do_action = function(ddu_type, key, args)
    if ddu_type == DDU_TYPE.FF then
      fn["ddu#ui#ff#do_action"](key, args)
    else
      fn["ddu#ui#filer#do_action"](key, args)
    end
  end,
  patch_local = fn["ddu#custom#patch_local"],
  item = {
    is_tree = function()
      return fn["ddu#ui#get_item"]()['isTree']
    end,
  },
}


-- ddu-ui-filer
local current_filer = 1
local filers = { 'filer_1', 'filer_2', 'filer_3', 'filer_4', }

local function show_ddu_filer()
  utils.begin_debug("show_ddu_filer")

  utils.echom("ddu-filer: " .. filers[current_filer])
  ddu.start({ name = filers[current_filer] })

  utils.end_debug("show_ddu_filer")
end
local function open_ddu_filer(window_id)
  current_filer = window_id
  show_ddu_filer()
end

-- ddu-ui-ff
local current_ff_name = 'buffer'
local function show_ddu_ff()
  utils.begin_debug("show_ddu_ff")

  utils.echom("ddu-ff: " .. current_ff_name)
  ddu.start({ name = current_ff_name })

  utils.end_debug("show_ddu_ff")
end
local function open_ddu_ff(name)
  current_ff_name = name
  show_ddu_ff()
end

local function win_all()
  return fn.range(1, fn.winnr('$'))
end

local function my_ddu_choosewin(src, args)
  utils.begin_debug("my_ddu_choosewin")
  utils.debug_echo("src: " .. src)
  utils.debug_echo("args", args)

  utils.try_catch {
    try = function()
      local path = args.items[1].action.path
      fn["choosewin#start"](win_all(), {auto_choose = true, hook_enable = false })
      vim.cmd('edit ' .. path)
    end,
    catch = function()
      if src == DDU_TYPE.FF then
        ddu.ff.do_action('itemAction', args)
      elseif src == DDU_TYPE.Filer then
        ddu.filer.do_action('itemAction', args)
      else
        -- call ddu#ui#filer#do_action('itemAction')
        utils.echoerr("failed my_ddu_choosewin")
      end
    end
  }
  utils.end_debug("my_ddu_choosewin")
end

local ddu_float_window = {
  col             = g.float_window_col,
  row             = g.float_window_row,
  width           = g.float_window_width,
  height          = g.float_window_height,
  preview_width   = 120,
  preview_col     = 0,
  preview_height  = g.ddu_float_window_height,
  border          = 'rounded',
  split           = 'floating',
}

local ddu_ui_params = {
  span = 2,

  split                   = ddu_float_window.split,
  floatingBorder          = ddu_float_window.border,
  filterFloatingPosition  = 'bottom',
  filterSplitDirection    = ddu_float_window.split,
  winRow                  = ddu_float_window.row,
  winCol                  = ddu_float_window.col,
  winWidth                = ddu_float_window.width,
  winHeight               = ddu_float_window.height,

  previewFloating         = true,
  previewVertical         = true,
  previewFloatingBorder   = ddu_float_window.border,
  previewFloatingZindex   = 10000,
  previewCol              = ddu_float_window.preview_col,
  previewWidth            = ddu_float_window.preview_width,
  previewHeight           = ddu_float_window.preview_height,
}



local function ddu_basic()
  utils.begin_debug('ddu basic')

  --  ddu.vim ------------------------------
--  ddu.patch_global({
--    ui = 'ff',
--    sources = {
--      { name = 'file_rec', params = {} },
--      { name = 'file' },
--      { name = 'buffer' },
--      { name = 'emoji' },
--    },
--    sourceOptions = {
--      ["_"] = {
--        columns   = {'icon_filename'},
--        matchers  = {'matcher_substring'},
--      },
--    },
--    filterParams = {
--      matcher_substring = {
--        highlightMatched = 'Search',
--      },
--    },
--    kindOptions = {
--      file            = { defaultAction = 'open',     },
--      file_old        = { defaultAction = 'open',     },
--      file_rec        = { defaultAction = 'open',     },
--      action          = { defaultAction = 'do',       },
--      word            = { defaultAction = 'append',   },
--      ["custom-list"] = { defaultAction = 'callback', },
--    },
--    uiParams = {
--      ["_"] = ddu_ui_params,
--    },
--    actionOptions = {
--      echo      = { quit = false, },
--      echoDiff  = { quit = false, },
--    },
--  })


  --  ddu-ui --------------------

  --  ddu-ui-ff
  -- if fn.has('macunix') then
  --   vim.cmd("brew install desktop-file-utils")
  -- end

  utils.end_debug('ddu basic')
end

local function ddu_ff()
  utils.begin_debug('ddu ff')

  ddu.action('kind', 'file',    'ff_mychoosewin',       function(args) my_ddu_choosewin(DDU_TYPE.FF, args) end)
  ddu.action('kind', 'word',    'ff_mychoosewin',       function(args) my_ddu_choosewin(DDU_TYPE.FF, args) end)

  ddu.action('kind', 'file',  'ff_open_buffer',         function() open_ddu_ff('buffer') end )
  ddu.action('kind', 'file',  'ff_open_mrw',            function() open_ddu_ff('mrw') end )
  ddu.action('kind', 'file',  'ff_open_mrw_current',    function() open_ddu_ff('mrw_current') end )
  ddu.action('kind', 'file',  'ff_open_emoji',          function() open_ddu_ff('emoji') end )

  ddu.action('kind', 'word', 'ff_open_buffer',          function() open_ddu_ff('buffer') end)
  ddu.action('kind', 'word', 'ff_open_mrw',             function() open_ddu_ff('mrw') end)
  ddu.action('kind', 'word', 'ff_open_mrw_current',     function() open_ddu_ff('mrw_current') end)
  ddu.action('kind', 'word', 'ff_open_emoji',           function() open_ddu_ff('emoji') end)


  if fn.has('win32') then
    ddu.action('kind', 'file', 'ff_open_clip_history', function() open_ddu_ff('clip_history') end )
    ddu.action('kind', 'word', 'ff_open_clip_history', function() open_ddu_ff('clip_history') end)
  end

--  ddu.action('kind', 'buffer',  'ff_open_buffer',       function() open_ddu_ff('buffer') end )
--  ddu.action('kind', 'buffer',  'ff_open_mrw',          function() open_ddu_ff('mrw') end )
--  ddu.action('kind', 'buffer',  'ff_open_mrw_current',  function() open_ddu_ff('mrw_current') end )
--  ddu.action('kind', 'buffer',  'ff_open_emoji',        function() open_ddu_ff('emoji') end )
--  ddu.action('kind', 'buffer',  'ff_open_clip_history', function() open_ddu_ff('clip_history') end )
--
--  ddu.action('kind', 'mrw',     'ff_open_buffer',       function() open_ddu_ff('buffer') end )
--  ddu.action('kind', 'mrw',     'ff_open_mrw',          function() open_ddu_ff('mrw') end )
--  ddu.action('kind', 'mrw',     'ff_open_mrw_current',  function() open_ddu_ff('mrw_current') end )
--  ddu.action('kind', 'mrw',     'ff_open_emoji',        function() open_ddu_ff('emoji') end )
--  ddu.action('kind', 'mrw',     'ff_open_clip_history', function() open_ddu_ff('clip_history') end )
--
--  ddu.action('kind', 'word',    'ff_open_buffer',       function() open_ddu_ff('buffer') end)
--  ddu.action('kind', 'word',    'ff_open_mrw',          function() open_ddu_ff('mrw') end)
--  ddu.action('kind', 'word',    'ff_open_mrw_current',  function() open_ddu_ff('mrw_current') end)
--  ddu.action('kind', 'word',    'ff_open_emoji',        function() open_ddu_ff('emoji') end)
--  ddu.action('kind', 'word',    'ff_open_clip_history', function() open_ddu_ff('clip_history') end)
--
--  -- ddu.action('kind', 'file',    'ff_open_buffer',       function() open_ddu_ff('buffer') end )
--  -- ddu.action('kind', 'file',    'ff_open_mrw',          function() open_ddu_ff('mrw') end )
--  -- ddu.action('kind', 'file',    'ff_open_mrw_current',  function() open_ddu_ff('mrw_current') end )
--  -- ddu.action('kind', 'file',    'ff_open_emoji',        function() open_ddu_ff('emoji') end )
--  -- ddu.action('kind', 'file',    'ff_open_clip_history', function() open_ddu_ff('clip_history') end )

  --  ddu-source-buffer
  ddu.patch_local('buffer', {
    ui = 'ff',
    sources = {
      {
        name  = 'buffer',
        param = { path = "~" },
      },
    },
    sourceOptions = {
      ["_"] = {
        columns = { 'filename' },
      },
    },
    kindOptions = {
      buffer = {
        defaultAction = 'open',
      },
    },
    uiParams = {
      ["_"] = ddu_ui_params,
      buffer = ddu_ui_params,
    }
  })

  api.nvim_create_user_command('DduBuffer', function() open_ddu_ff("buffer") end, {})

  --  ddu-source-file_old
  ddu.patch_local('file_old', {
    ui = 'ff',
    sources = {
      {
        name  = 'file_old',
        param = {},
      },
    },
    kindOptions = {
      file_old = {
        defaultAction = 'open',
      },
    },
    uiParams = {
      ["_"] = ddu_ui_params,
      file_old = ddu_ui_params,
    }
  })

  api.nvim_create_user_command('DduFileOld', function() open_ddu_ff("file_old") end, {})

  --  ddu-source-emoji
  ddu.patch_local('emoji', {
    ui = 'ff',
    sources = {
      {
        name  = 'emoji',
        param = {},
      },
    },
    kindOptions = {
      emoji = {
        defaultAction = 'append',
      },
      word = {
        defaultAction = 'append',
      },
    },
    uiParams = {
      ["_"] = ddu_ui_params,
      emoji = ddu_ui_params,
    }
  })

  api.nvim_create_user_command('DduEmoji', function() open_ddu_ff("emoji") end, {})

  --  ddu-source-mrw
  local mr_source = {
    name  = 'mr',
    param = { kind = 'mrw' },
  }

  ddu.patch_local('mrw', {
    ui = 'ff',
    sources = {
      mr_source,
    },
    kindOptions = {
      mrw = {
        defaultAction = 'open',
      },
    },
    uiParams = {
      ["_"] = ddu_ui_params,
      mr = ddu_ui_params,
    }
  })

  api.nvim_create_user_command('DduMrw', function() open_ddu_ff("mrw") end, {})

  local mrw_source = {
    name  = 'mr',
    param ={ kind = 'mrw', current = true },
  }
  ddu.patch_local('mrw_current', {
    ui = 'ff',
    sources = {
      mrw_source,
    },
    kindOptions = {
      mrw = {
        defaultAction = 'open',
      },
    },
    uiParams = {
      ["_"] = ddu_ui_params,
      mrw = ddu_ui_params,
    }
  })

  api.nvim_create_user_command('DduMrwCurrent', function() open_ddu_ff("mrw_current") end, {})


  --  windows-clipboard-history

  if fn.has('win32') then
    ddu.patch_local('clip_history', {
      ui = 'ff',
      sources = {
        {
          name   = 'windows-clipboard-history',
          param  = { prefix = 'Clip:' },
        }
      },
      kindOptions = {
        clip_history = {
          defaultAction = 'yank',
        },
      },
      uiParams = {
        ["_"]         = ddu_ui_params,
        clip_history  = ddu_ui_params,
      }
    })

    api.nvim_create_user_command('DduClip', function() open_ddu_ff("clip_history") end, {})
  end

  local function ddu_ff_my_settings()
    utils.begin_debug('ddu_ff_my_settings')

    keymap.set("n", "<F5>",     function() ddu.ff.do_action('itemAction', { name = 'ff_open_buffer',       quit = true }) end, km_opts.bns)
    keymap.set("n", "<F6>",     function() ddu.ff.do_action('itemAction', { name = 'ff_open_mrw',          quit = true }) end, km_opts.bns)
    keymap.set("n", "<F7>",     function() ddu.ff.do_action('itemAction', { name = 'ff_open_mrw_current',  quit = true }) end, km_opts.bns)
    keymap.set("n", "<F8>",     function() ddu.ff.do_action('itemAction', { name = 'ff_open_emoji',        quit = true }) end, km_opts.bns)

    if fn.has('win32') then
      keymap.set("n", "<F9>",   function() ddu.ff.do_action('itemAction', { name = 'ff_open_clip_history', quit = true }) end, km_opts.bns)
    end

    keymap.set("n", "<CR>",     function() ddu.ff.do_action('itemAction', { name = 'ff_mychoosewin', quit = true }) end, km_opts.bns)
    keymap.set("n", "<Space>",  function() ddu.ff.do_action('toggleSelectItem')                                     end, km_opts.bns)
    keymap.set("n", "i",        function() ddu.ff.do_action('openFilterWindow')                                     end, km_opts.bns)
    keymap.set("n", "P",        function() ddu.ff.do_action('preview')                                              end, km_opts.bns)
    keymap.set("n", "q",        function() ddu.ff.do_action('quit')                                                 end, km_opts.bns)

    keymap.set("n", "l",        function() ddu.ff.do_action('itemAction', { name = 'open', params = { command = 'vsplit'}, quit = true }) end, km_opts.bns)
    keymap.set("n", "L",        function() ddu.ff.do_action('itemAction', { name = 'open', params = { command = 'split'},  quit = true }) end, km_opts.bns)

    keymap.set("n", "d",        function() ddu.ff.do_action('itemAction', { name = 'delete' }) end, km_opts.ebns)

    utils.end_debug('ddu_ff_my_settings')
  end

  local augroup_id = api.nvim_create_augroup('my_ddu_ff_preference', { clear = true })
  api.nvim_create_autocmd('FileType', {
    group = augroup_id,
    pattern = { "ddu-ff", },
    callback = ddu_ff_my_settings
  })

  utils.end_debug('ddu ff')
end

local function ddu_filer()
  utils.begin_debug('ddu filer')

  local ddu_filer_sources = {
    {
      name = 'file',
      param = {},
    }
  }
  local ddu_filer_source_options = {
    ["_"] = {
      columns = { 'icon_filename' },
    },
  }
  local ddu_filer_kind_options = {
    file = {
      defaultAction = 'open',
    },
  }
  local ddu_filer_action_options = {
    narrow = {
      quit = false,
    },
  }

  local ddu_ui_filer_params = ddu_ui_params
  ddu_ui_filer_params.border = ddu_float_window.border
  ddu_ui_filer_params.search = fn.expand('%:p')
  ddu_ui_filer_params.sort = 'filename'
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
      sort = 'filename',
      sortTreesFirst = true,
    }
  }

  for _, name in ipairs(filers) do
    ddu.patch_local(name, {
      ui            = 'filer',
      name          = name,
      sources       = ddu_filer_sources,
      sourceOptions = ddu_filer_source_options,
      kindOptions   = ddu_filer_kind_options,
      actionOptions = ddu_filer_action_options,
      uiParams      = ddu_filer_uiparams,
    })
  end

  local function ddu_filer_my_settings()
    utils.begin_debug('ddu_filer_my_settings')

    ddu.action('kind', 'file', 'open_filer1', function() open_ddu_filer(1) end)
    ddu.action('kind', 'file', 'open_filer2', function() open_ddu_filer(2) end)
    ddu.action('kind', 'file', 'open_filer3', function() open_ddu_filer(3) end)
    ddu.action('kind', 'file', 'open_filer4', function() open_ddu_filer(4) end)

    utils.debug_echo('basic keymaps')
    -- basic actions
    keymap.set("n", "q", function() ddu.filer.do_action('quit')          end, km_opts.bns)
    keymap.set("n", "z", function() ddu.filer.do_action('quit')          end, km_opts.bns)
    -- TODO: redraw
    -- nnoremap <buffer><silent> R     <Cmd>call ddu#ui#filer#do_action('refreshItems')<Bar>redraw<CR>
    keymap.set("n", "R", function() ddu.filer.do_action('refreshItems')  end, km_opts.bns)
    keymap.set("n", "a", function() ddu.filer.do_action('chooseAction')  end, km_opts.bns)
    keymap.set("n", "P", function() ddu.filer.do_action('preview')       end, km_opts.bns)

    -- change window
    keymap.set("n", "<F5>", function() ddu.filer.do_action('itemAction', { name = 'open_filer1', params = { id = 0 }, quit = true }) end, km_opts.bns)
    keymap.set("n", "<F6>", function() ddu.filer.do_action('itemAction', { name = 'open_filer2', params = { id = 1 }, quit = true }) end, km_opts.bns)
    keymap.set("n", "<F7>", function() ddu.filer.do_action('itemAction', { name = 'open_filer3', params = { id = 2 }, quit = true }) end, km_opts.bns)
    keymap.set("n", "<F8>", function() ddu.filer.do_action('itemAction', { name = 'open_filer4', params = { id = 3 }, quit = true }) end, km_opts.bns)

    utils.debug_echo('change dir keymaps')
    -- change directory (path)
    keymap.set("n", "<CR>", function() return ddu.item.is_tree() and ddu.filer.do_action('itemAction', { name = 'narrow'}) or ddu.do_action(DDU_TYPE.Filer, 'itemAction', { name = 'filer_mychoosewin', quit = true })         end, km_opts.ebns)
    keymap.set("n", "h",    function() return ddu.item.is_tree() and ddu.filer.do_action('collapseItem')                                                                                                                       end, km_opts.ebns)
--    keymap.set("n", "h",    function() return ddu.item.is_tree() and ddu.filer.do_action('collapseItem')                   or utils.echoe('cannot close this item')                                                            end, km_opts.ebns)
    keymap.set("n", "l",    function() return ddu.item.is_tree() and ddu.filer.do_action('expandItem')                     or ddu.do_action(DDU_TYPE.Filer, 'itemAction', { name = 'open', params = { command = 'vsplit' } })  end, km_opts.ebns)
    keymap.set("n", "L",    function() return ddu.item.is_tree() and ddu.filer.do_action('expandItem')                     or ddu.do_action(DDU_TYPE.Filer, 'itemAction', { name = 'open', params = { command = 'split' } })   end, km_opts.ebns)

    utils.debug_echo('change dir alias keymaps')
    -- change directory aliases
    keymap.set("n", "^",    function() ddu.filer.do_action('itemAction', { name = "narrow", params = { path = fn.expand(g.my_initvim_path) } }) end, km_opts.bns)
    keymap.set("n", "|",    function() ddu.filer.do_action('itemAction', { name = "narrow", params = { path = fn.expand("~/repos") } })         end, km_opts.bns)
    keymap.set("n", "~",    function() ddu.filer.do_action('itemAction', { name = "narrow", params = { path = fn.expand("~") } })               end, km_opts.bns)
    keymap.set("n", "=",    function() ddu.filer.do_action('itemAction', { name = "narrow", params = { path = fn.expand("~/Documents") } })     end, km_opts.bns)
    keymap.set("n", "<BS>", function() ddu.filer.do_action('itemAction', { name = "narrow", params = { path = ".." } })                         end, km_opts.bns)
    keymap.set("n", "C",    function() ddu.filer.do_action('itemAction', { name = "cd" })                                                       end, km_opts.bns)
    keymap.set("n", "c",    function() ddu.filer.do_action('itemAction', { name = "copy" })                                                     end, km_opts.bns)
    keymap.set("n", "x",    function() ddu.filer.do_action('itemAction', { name = "cut" })                                                      end, km_opts.bns)
    keymap.set("n", "p",    function() ddu.filer.do_action('itemAction', { name = "paste" })                                                    end, km_opts.bns)
    keymap.set("n", "m",    function() ddu.filer.do_action('itemAction', { name = "move" })                                                     end, km_opts.bns)
    keymap.set("n", "b",    function() ddu.filer.do_action('itemAction', { name = "newFile" })                                                  end, km_opts.bns)
    keymap.set("n", "B",    function() ddu.filer.do_action('itemAction', { name = "newDirectory" })                                             end, km_opts.bns)
    keymap.set("n", "y",    function() ddu.filer.do_action('itemAction', { name = "yank" })                                                     end, km_opts.bns)
    keymap.set("n", "d",    function() ddu.filer.do_action('itemAction', { name = "delete" })                                                   end, km_opts.bns)
    keymap.set("n", "r",    function() ddu.filer.do_action('itemAction', { name = "rename" })                                                   end, km_opts.bns)

    utils.end_debug('ddu_filer_my_settings')
  end

  ddu.action('kind', 'file', 'filer_mychoosewin', function(args) return my_ddu_choosewin(DDU_TYPE.Filer, args) end)

  local augroup_id = api.nvim_create_augroup('my_ddu_filer_preference', { clear = true })
  api.nvim_create_autocmd({ 'TabEnter', 'WinEnter', 'CursorHold', 'FocusGained' }, {
    group = augroup_id,
    pattern = "*",
    callback = function ()
      ddu.filer.do_action('checkItems')
    end
  })
  api.nvim_create_autocmd('FileType', {
    group = augroup_id,
    pattern = { "ddu-filer" },
    callback = function ()
      ddu_filer_my_settings()
    end
  })

  utils.end_debug('ddu filer')
end

return {
  {
    lazy = true,
    'Shougo/ddu.vim',
    dependencies = {
      'vim-denops/denops.vim',

      'Shougo/ddu-ui-ff',
      'Shougo/ddu-ui-filer',

      'Shougo/ddu-source-action',
      'Shougo/ddu-source-buffer',
      'liquidz/ddu-source-custom-list',
      '4513ECHO/ddu-source-emoji',
      'Shougo/ddu-source-file',
      'Shougo/ddu-source-file_old',
      'Shougo/ddu-source-file_rec',
      'kuuote/ddu-source-mr',
      'gamoutatsumi/ddu-source-nvim-lsp',
      '4513ECHO/ddu-source-source',

      'Shougo/ddu-filter-matcher_substring',

      'Shougo/ddu-kind-file',
      'Shougo/ddu-kind-word',

      'Shougo/ddu-column-filename',
      'ryota2357/ddu-column-icon_filename',

      'matsui54/ddu-vim-ui-select',

      'Milly/windows-clipboard-history.vim',
    },
    config = function()
      ddu_basic()
      ddu_ff()
      ddu_filer()
      api.nvim_create_user_command("DduFiler",  show_ddu_filer, {})
      api.nvim_create_user_command('DduFF',     show_ddu_ff,    {})
    end,
    cmd = { "DduFiler", "DduFF", },
    keys = {
      { "z", "<cmd>DduFiler<CR>", mode = "n" },
      { "Z", "<cmd>DduFF<CR>", mode = "n" },
    },
  },
  {
    lazy = true,
    'kuuote/ddu-source-mr',
    dependencies = { "lambdalisue/mr.vim" },
  }
}
