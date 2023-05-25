local utils = require('utils')

local g = vim.g
local fn = vim.fn
local api = vim.api
local cmd = vim.cmd
local keymap = vim.keymap

local DDU_TYPE = { FF = 0, Filer = 1 }

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
      return fn["ddu#ui#ff#do_action"](key, args)
    end

    return fn["ddu#ui#filer#do_action"](key, args)
  end,
}


-- ddu-ui-filer
local current_filer = 1
local filers = { 'filer_1', 'filer_2', 'filer_3', 'filer_4', }

local function show_ddu_filer()
  utils.begin_debug("show_ddu_filer")
  utils.debug_echo("filers: ", filers)
  utils.debug_echo("current_filer: " .. current_filer)
  utils.debug_echo("name: " .. filers[current_filer])

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
  utils.debug_echo("begin my_ddu_choosewin")
  utils.debug_echo("src: " .. src)
  utils.debug_echo("args", args)

  utils.try_catch {
    try = function()
      local path = args.items[1].action.path
      fn["choosewin#start"](win_all(), {auto_choose = true, hook_enable = false })
      cmd('edit ' .. path)
    end,
    catch = function()
      ddu.do_action(src, 'itemAction', args)
--      if src == DDU_TYPE.FF then
--        fn["ddu#ui#ff#do_action"]('itemAction', args)
--      elseif src == DDU_TYPE.Filer then
--        fn["ddu#ui#filer#do_action"]('itemAction', args)
--      else
--        -- call ddu#ui#filer#do_action('itemAction')
--        utils.echoerr("failed my_ddu_choosewin")
--      end
    end
  }
  utils.debug_echo("end my_ddu_choosewin")
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
  ddu.patch_global({
    ui = 'ff',
    sources = {
      { name = 'file_rec', params = {} },
      { name = 'file' },
      { name = 'buffer' },
      { name = 'emoji' },
    },
    sourceOptions = {
      ["_"] = {
        columns   = {'icon_filename'},
        matchers  = {'matcher_substring'},
      },
    },
    filterParams = {
      matcher_substring = {
        highlightMatched = 'Search',
      },
    },
    kindOptions = {
      file            = { defaultAction = 'open',     },
      file_old        = { defaultAction = 'open',     },
      file_rec        = { defaultAction = 'open',     },
      action          = { defaultAction = 'do',       },
      word            = { defaultAction = 'append',   },
      ["custom-list"] = { defaultAction = 'callback', },
    },
    uiParams = {
      ["_"] = ddu_ui_params,
    },
    actionOptions = {
      echo      = { quit = false, },
      echoDiff  = { quit = false, },
    },
  })


  --  ddu-ui --------------------

  --  ddu-ui-ff
  -- if fn.has('macunix') then
  --   vim.cmd("brew install desktop-file-utils")
  -- end

  utils.end_debug('ddu basic')
end

local function ddu_ff()
  utils.begin_debug('ddu ff')

  ddu.action('kind', 'file', 'ff_mychoosewin',       function(args) my_ddu_choosewin(DDU_TYPE.FF, args) end)

  ddu.action('kind', 'file', 'ff_open_buffer',       function() open_ddu_ff('buffer') end )
  ddu.action('kind', 'file', 'ff_open_mrw',          function() open_ddu_ff('mrw') end )
  ddu.action('kind', 'file', 'ff_open_mrw_current',  function() open_ddu_ff('mrw_current') end )
  ddu.action('kind', 'file', 'ff_open_emoji',        function() open_ddu_ff('emoji') end )
  ddu.action('kind', 'file', 'ff_open_clip_history', function() open_ddu_ff('clip_history') end )

  -- ddu.action('kind', 'buffer', 'ff_open_buffer',       { args -> open_ddu_ff('buffer',        false) })
  -- ddu.action('kind', 'buffer', 'ff_open_mrw',          { args -> open_ddu_ff('mrw',           false) })
  -- ddu.action('kind', 'buffer', 'ff_open_mrw_current',  { args -> open_ddu_ff('mrw_current',   false) })
  -- ddu.action('kind', 'buffer', 'ff_open_emoji',        { args -> open_ddu_ff('emoji',         false) })
  -- ddu.action('kind', 'buffer', 'ff_open_clip_history', { args -> open_ddu_ff('clip_history',  true) })

  -- ddu.action('kind', 'mrw', 'ff_open_buffer',       { args -> open_ddu_ff('buffer',        false) })
  -- ddu.action('kind', 'mrw', 'ff_open_mrw',          { args -> open_ddu_ff('mrw',           false) })
  -- ddu.action('kind', 'mrw', 'ff_open_mrw_current',  { args -> open_ddu_ff('mrw_current',   false) })
  -- ddu.action('kind', 'mrw', 'ff_open_emoji',        { args -> open_ddu_ff('emoji',         false) })
  -- ddu.action('kind', 'mrw', 'ff_open_clip_history', { args -> open_ddu_ff('clip_history',  true) })

  ddu.action('kind', 'word', 'ff_open_buffer',       function() open_ddu_ff('buffer') end)
  ddu.action('kind', 'word', 'ff_open_mrw',          function() open_ddu_ff('mrw') end)
  ddu.action('kind', 'word', 'ff_open_mrw_current',  function() open_ddu_ff('mrw_current') end)
  ddu.action('kind', 'word', 'ff_open_emoji',        function() open_ddu_ff('emoji') end)
  ddu.action('kind', 'word', 'ff_open_clip_history', function() open_ddu_ff('clip_history') end)

  if fn.has('win32') then
    ddu.action('kind', 'windows-clipboard-history', 'ff_open_buffer',       function() open_ddu_ff('buffer') end)
    ddu.action('kind', 'windows-clipboard-history', 'ff_open_mrw',          function() open_ddu_ff('mrw') end)
    ddu.action('kind', 'windows-clipboard-history', 'ff_open_mrw_current',  function() open_ddu_ff('mrw_current') end)
    ddu.action('kind', 'windows-clipboard-history', 'ff_open_emoji',        function() open_ddu_ff('emoji') end)
    ddu.action('kind', 'windows-clipboard-history', 'ff_open_clip_history', function() open_ddu_ff('clip_history') end)
  end

  local function ddu_ff_my_settings()
    keymap.set("n", "z", function() return fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_buffer',       quit = true }) end, { buffer = true, silent = true })
    keymap.set("n", "x", function() return fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_mrw',          quit = true }) end, { buffer = true, silent = true })
    keymap.set("n", "c", function() return fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_mrw_current',  quit = true }) end, { buffer = true, silent = true })
    keymap.set("n", "v", function() return fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_emoji',        quit = true }) end, { buffer = true, silent = true })

    if fn.has('win32') then
      keymap.set("n", "b", function() fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_clip_history', quit = true }) end, { buffer = true, silent = true })
    end
    -- nnoremap <buffer><silent>   <F12> <Cmd>fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_buffer',       'quit': true })<CR>
    -- nnoremap <buffer><silent>   <F11> <Cmd>fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_mrw',          'quit': true })<CR>
    -- nnoremap <buffer><silent>   <F10> <Cmd>fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_mrw_current',  'quit': true })<CR>
    -- nnoremap <buffer><silent>   <F9>  <Cmd>fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_emoji',        'quit': true })<CR>
    -- if has('win32')
    --   nnoremap <buffer><silent> <F8>  <Cmd>fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_clip_history', 'quit': true })<CR>
    -- end

    keymap.set("n", "<CR>",     function() fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_mychoosewin', quit = true }) end, { buffer = true, silent = true })
    keymap.set("n", "<Space>",  function() fn["ddu#ui#ff#do_action"]('toggleSelectItem')                                     end, { buffer = true, silent = true })
    keymap.set("n", "i",        function() fn["ddu#ui#ff#do_action"]('openFilterWindow')                                     end, { buffer = true, silent = true })
    keymap.set("n", "P",        function() fn["ddu#ui#ff#do_action"]('preview')                                              end, { buffer = true, silent = true })
    keymap.set("n", "q",        function() fn["ddu#ui#ff#do_action"]('quit')                                                 end, { buffer = true, silent = true })
    keymap.set("n", "l",        function() fn["ddu#ui#ff#do_action"]('itemAction', { name = 'open', params = { command = 'vsplit'}, quit = true }) end, { buffer = true, silent = true, expr = true })
    keymap.set("n", "L",        function() fn["ddu#ui#ff#do_action"]('itemAction', { name = 'open', params = { command = 'split'},  quit = true }) end, { buffer = true, silent = true, expr = true })
    keymap.set("n", "d",        function() fn["ddu#ui#ff#do_action"]('itemAction', { name = 'delete' }) end, { buffer = true, silent = true })
  end

  local augroup_id = api.nvim_create_augroup('my_ddu_ff_preference', { clear = true })
  api.nvim_create_autocmd('FileType', {
    group = augroup_id,
    pattern = {
      "ddu-ff",
      "ddu-ff-buffer",
      "ddu-ff-mrw",
      "ddu-ff-mrw_current",
      "ddu-ff-emoji",
      "ddu-ff-clip_history",
    },
    callback = function ()
      ddu_ff_my_settings()
    end
  })


  --  ddu-source-buffer
  fn["ddu#custom#patch_local"]('buffer', {
    ui = 'ff',
    sources = {
      {
        name  = 'buffer',
        param = { path = "~" },
      },
    },
    sourceOptions = {
      ["_"] = {
        columns = { 'icon_filename' },
      },
    },
    kindOptions = {
      buffer = {
        defaultAction = 'open',
      },
    },
    uiParams = {
      buffer = ddu_ui_params,
    }
  })

  api.nvim_create_user_command('DduBuffer', function() open_ddu_ff("buffer") end, {})

  --  ddu-source-file_old
  fn["ddu#custom#patch_local"]('file_old', {
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
      file_old = ddu_ui_params,
    }
  })

  api.nvim_create_user_command('DduFileOld', function() open_ddu_ff("file_old") end, {})

  --  ddu-source-emoji
  fn["ddu#custom#patch_local"]('emoji', {
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
      emoji = ddu_ui_params,
    }
  })

  api.nvim_create_user_command('DduEmoji', function() open_ddu_ff("emoji") end, {})

  --  ddu-source-mrw
  local mr_source = {
    name  = 'mr',
    param = { kind = 'mrw' },
  }

  fn["ddu#custom#patch_local"]('mrw', {
    ui = 'ff',
    sources = {
      mr_source,
    },
    kindOptions = {
      mrw = {
        defaultAction = 'open',
      },
    },
  })

  api.nvim_create_user_command('DduMrw', function() open_ddu_ff("mrw") end, {})

  local mrw_source = {
    name  = 'mr',
    param ={ kind = 'mrw', current = true },
  }
  fn["ddu#custom#patch_local"]('mrw_current', {
    ui = 'ff',
    sources = {
      mrw_source,
    },
    kindOptions = {
      mrw = {
        defaultAction = 'open',
      },
    },
  })

  api.nvim_create_user_command('DduMrwCurrent', function() open_ddu_ff("mrw_current") end, {})


  --  windows-clipboard-history

  if fn.has('win32') then
    fn["ddu#custom#patch_local"]('clip_history', {
      ui = 'ff',
      sources = {
        {
          name   = 'windows-clipboard-history',
          param  = { prefix = 'Clip:' },
        }
      },
    })

    api.nvim_create_user_command('DduClip', function() open_ddu_ff("clip_history") end, {})
  end

  utils.end_debug('ddu ff')
end

local function ddu_filer()
  utils.begin_debug('ddu filer')
  --
  ddu.action('kind', 'file', 'open_filer1', function() open_ddu_filer(1) end)
  ddu.action('kind', 'file', 'open_filer2', function() open_ddu_filer(2) end)
  ddu.action('kind', 'file', 'open_filer3', function() open_ddu_filer(3) end)
  ddu.action('kind', 'file', 'open_filer4', function() open_ddu_filer(4) end)

  local function ddu_filer_my_settings()
    utils.begin_debug('ddu_filer_my_settings')

    utils.debug_echo('basic keymaps')
    -- basic actions
    keymap.set("n", "q", function() fn["ddu#ui#filer#do_action"]('quit')          end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "z", function() fn["ddu#ui#filer#do_action"]('quit')          end, { noremap = true, silent = true, buffer = true })
    -- TODO: redraw
    -- nnoremap <buffer><silent> R     <Cmd>call ddu#ui#filer#do_action('refreshItems')<Bar>redraw<CR>
    keymap.set("n", "R", function() fn["ddu#ui#filer#do_action"]('refreshItems')  end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "a", function() fn["ddu#ui#filer#do_action"]('chooseAction')  end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "P", function() fn["ddu#ui#filer#do_action"]('preview')       end, { noremap = true, silent = true, buffer = true })

    -- change window
    keymap.set("n", "<F5>", function() fn["ddu#ui#filer#do_action"]('itemAction', { name = 'open_filer1', params = { id = 0 }, quit = true }) end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "<F6>", function() fn["ddu#ui#filer#do_action"]('itemAction', { name = 'open_filer2', params = { id = 1 }, quit = true }) end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "<F7>", function() fn["ddu#ui#filer#do_action"]('itemAction', { name = 'open_filer3', params = { id = 2 }, quit = true }) end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "<F8>", function() fn["ddu#ui#filer#do_action"]('itemAction', { name = 'open_filer4', params = { id = 3 }, quit = true }) end, { noremap = true, silent = true, buffer = true })

    utils.debug_echo('change dir keymaps')
    -- change directory (path)
    keymap.set("n", "<CR>", function()
      return fn["ddu#ui#get_item"]()['isTree']
      and  fn["ddu#ui#filer#do_action"]('itemAction', { name = 'narrow'})
      or   fn["ddu#ui#filer#do_action"]('itemAction', { name = 'filer_mychoosewin', quit = true })
    end, { noremap = true, silent = true, buffer = true, expr = true })
    keymap.set("n", "h", function()
      return fn["ddu#ui#get_item"]()['isTree']
      and  fn["ddu#ui#filer#do_action"]('collapseItem')
      or   utils.echoe('cannot close this item')
    end, { noremap = true, silent = true, buffer = true, expr = true })
    keymap.set("n", "l", function()
      return fn["ddu#ui#get_item"]()['isTree']
      and fn["ddu#ui#filer#do_action"]('expandItem')
      or  fn["ddu#ui#filer#do_action"]('itemAction', { name = 'open', params = { command = 'vsplit' } })
    end, { noremap = true, silent = true, buffer = true, expr = true })
    keymap.set("n", "L", function()
      return fn["ddu#ui#get_item"]()['isTree']
      and fn["ddu#ui#filer#do_action"]('expandItem')
      or  fn["ddu#ui#filer#do_action"]('itemAction', { name = 'open', params = { command = 'split' } })
    end, { noremap = true, silent = true, buffer = true, expr = true })

    utils.debug_echo('change dir alias keymaps')
    -- change directory aliases
    keymap.set("n", "^",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "narrow", params = { path = fn.expand(g.my_initvim_path) } }) end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "|",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "narrow", params = { path = fn.expand("~/repos") } })             end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "~",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "narrow", params = { path = fn.expand("~/Documents") } })         end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "<BS>", function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "narrow", params = { path = ".." } })                             end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "C",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "cd" })                                                           end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "c",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "copy" })                                                         end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "x",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "cut" })                                                          end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "p",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "paste" })                                                        end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "m",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "move" })                                                         end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "b",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "newFile" })                                                      end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "B",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "newDirectory" })                                                 end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "y",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "yank" })                                                         end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "d",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "delete" })                                                       end, { noremap = true, silent = true, buffer = true })
    keymap.set("n", "r",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "rename" })                                                       end, { noremap = true, silent = true, buffer = true })

    utils.end_debug('ddu_filer_my_settings')
  end

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

  local ddu_ui_params_default = ddu_ui_params
  ddu_ui_params_default.border = "rounded"
  ddu_ui_params_default.search = fn.expand('%:p')
  ddu_ui_params_default.sort = 'filename'
  ddu_ui_params_default.sortTreesFirst = true
  ddu_ui_params_default.splitDirection = "topleft"

  local ddu_filer_ui_params = {
    ["_"] = ddu_ui_params_default,
    filer = ddu_ui_params_default,
    icon_filename = {
      span = 2,
      padding = 2,
      iconWidth = 2,
      useLinkIcon = "grayout",
      sort = 'filename',
      sortTreesFirst = true,
    }
  }

--  local ddu_filer_params = {
--    ui            = 'filer',
--    sources       = ddu_filer_sources,
--    sourceOptions = ddu_filer_source_options,
--    kindOptions   = ddu_filer_kind_options,
--    actionOptions = ddu_filer_action_options,
--    uiParams      = ddu_filer_ui_params,
--  }

--  fn["ddu#custom#patch_local"]('filer_1', {
--    ui            = 'filer',
--    name          = 'filer_1',
--    sources       = ddu_filer_sources,
--    sourceOptions = ddu_filer_source_options,
--    kindOptions   = ddu_filer_kind_options,
--    actionOptions = ddu_filer_action_options,
--    uiParams      = ddu_filer_ui_params,
--  })
--  fn["ddu#custom#patch_local"]('filer_2', {
--    ui            = 'filer',
--    name          = 'filer_2',
--    sources       = ddu_filer_sources,
--    sourceOptions = ddu_filer_source_options,
--    kindOptions   = ddu_filer_kind_options,
--    actionOptions = ddu_filer_action_options,
--    uiParams      = ddu_filer_ui_params,
--  })
--  fn["ddu#custom#patch_local"]('filer_3', {
--    ui            = 'filer',
--    name          = 'filer_3',
--    sources       = ddu_filer_sources,
--    sourceOptions = ddu_filer_source_options,
--    kindOptions   = ddu_filer_kind_options,
--    actionOptions = ddu_filer_action_options,
--    uiParams      = ddu_filer_ui_params,
--  })
--  fn["ddu#custom#patch_local"]('filer_4', {
--    ui            = 'filer',
--    name          = 'filer_4',
--    sources       = ddu_filer_sources,
--    sourceOptions = ddu_filer_source_options,
--    kindOptions   = ddu_filer_kind_options,
--    actionOptions = ddu_filer_action_options,
--    uiParams      = ddu_filer_ui_params,
--  })

  for _, name in ipairs(filers) do
    fn["ddu#custom#patch_local"](name, {
      ui            = 'filer',
      name          = name,
      sources       = ddu_filer_sources,
      sourceOptions = ddu_filer_source_options,
      kindOptions   = ddu_filer_kind_options,
      actionOptions = ddu_filer_action_options,
      uiParams      = ddu_filer_ui_params,
    })
  end

  local ddu_ui_params_4preference = ddu_ui_params_default
  ddu_ui_params_4preference.search = fn.expand(g.my_initvim_path)
  --
  ddu.action('kind', 'file', 'filer_mychoosewin', function(args) return my_ddu_choosewin(DDU_TYPE.Filer, args) end)

  local augroup_id = api.nvim_create_augroup('my_ddu_ff_preference', { clear = true })
  api.nvim_create_autocmd({ 'TabEnter', 'WinEnter', 'CursorHold', 'FocusGained' }, {
    group = augroup_id,
    pattern = "*",
    callback = function ()
      fn["ddu#ui#filer#do_action"]('checkItems')
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
    'Shougo/ddu.vim',
    lazy = true,
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
}
