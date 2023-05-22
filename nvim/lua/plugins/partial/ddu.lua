local utils = require('utils')

local fn = vim.fn

-- ddu-ui-filer
local current_filer = 0
local filers = { 'filer_1', 'filer_2', 'filer_3', 'filer_4', }

local function show_ddu_filer(window_id)
  local current_filer = window_id
  local name = filers[window_id]
  fn["ddu#start"]({ name = name })
end

-- ddu-ui-ff
local current_ff_name = 'buffer'
local function show_ddu_ff()
  fn["ddu#start"]({ name = current_ff_name })
end
local function open_ddu_ff(name)
  fn.echom(name)
  fn["ddu#start"]({ name = name })
end

local function win_all()
  return fn.range(1, fn.winnr('$'))
end

local function MyDduChooseWin(src, args)
  utils.try_catch {
    try = function()
      local path = args[0].action.path
      fn["choosewin#start"](win_all(), {auto_choose = true, hook_enable = false })
      vim.cmd('edit ' .. path)
    end,
    catch = function()
      if src == 0 then
        -- call ddu#ui#ff#do_action('itemAction')
        fn["ddu#ui#ff#do_action"]('itemAction', args)
      else
        -- call ddu#ui#filer#do_action('itemAction')
        fn["ddu#ui#filer#do_action"]('itemAction', args)
      end
    end
  }
end

local function ddu_basic()
  utils.begin_debug('ddu basic')

  vim.g.ddu_float_window_col            = vim.g.float_window_col
  vim.g.ddu_float_window_row            = vim.g.float_window_row
  vim.g.ddu_float_window_width          = vim.g.float_window_width
  vim.g.ddu_float_window_height         = vim.g.float_window_height
  vim.g.ddu_float_window_preview_width  = 120
  vim.g.ddu_float_window_preview_col    = 0
  vim.g.ddu_float_window_preview_height = vim.g.ddu_float_window_height

  vim.g.floating_ddu_ui_params = {
    span = 2,

    split                   = 'floating',
    floatingBorder          = 'rounded',
    filterFloatingPosition  = 'bottom',
    filterSplitDirection    = 'floating',
    winRow                  = vim.g.ddu_float_window_row,
    winCol                  = vim.g.ddu_float_window_col,
    winWidth                = vim.g.ddu_float_window_width,
    winHeight               = vim.g.ddu_float_window_height,

    previewFloating         = true,
    previewVertical         = true,
    previewFloatingBorder   = 'rounded',
    previewFloatingZindex   = 10000,
    previewCol              = vim.g.ddu_float_window_preview_col,
    previewWidth            = vim.g.ddu_float_window_preview_width,
    previewHeight           = vim.g.ddu_float_window_preview_height,
  }

  --  ddu.vim ------------------------------
  fn['ddu#custom#patch_global']({
    ui = 'ff',
    sources = {
      { name = 'file_rec', params = {} },
      { name = 'file' },
      { name = 'buffer' },
      { name = 'emoji' },
    },
    sourceOptions = {
      _ = {
        columns = {'icon_filename'},
        matchers = {'matcher_substring'},
      },
      dein_update = {
        matchers = {'matcher_dein_update'},
      },
    },
    filterParams = {
      matcher_substring = {
        highlightMatched = 'Search',
      },
    },
    kindOptions = {
      file =          { defaultAction = 'open', },
      file_old =      { defaultAction = 'open', },
      file_rec =      { defaultAction = 'open', },
      action =        { defaultAction = 'do', },
      word =          { defaultAction = 'append', },
      dein_update =   { defaultAction = 'viewDiff', },
      ["custom-list"] =  { defaultAction = 'callback', },
    },
    uiParams = {
      _ = vim.g.floating_ddu_ui_params,
    },
    actionOptions = {
      echo =     { quit = false, },
      echoDiff = { quit = false, },
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
  if vim.g.is_enable_my_debug then
    fn.echo "begin /plugins/ff.ddu.vim load"
  end

  fn["ddu#custom#action"]('kind', 'file', 'ff_mychoosewin', function(args) return MyDduChooseWin(0, args) end)

  -- vim.api.nvim_create_user_command('DduFF', show_ddu_ff, {})

  fn["ddu#custom#action"]('kind', 'file', 'ff_open_buffer',       function() return open_ddu_ff('buffer') end )
  fn["ddu#custom#action"]('kind', 'file', 'ff_open_mrw',          function() return open_ddu_ff('mrw') end )
  fn["ddu#custom#action"]('kind', 'file', 'ff_open_mrw_current',  function() return open_ddu_ff('mrw_current') end )
  fn["ddu#custom#action"]('kind', 'file', 'ff_open_emoji',        function() return open_ddu_ff('emoji') end )
  fn["ddu#custom#action"]('kind', 'file', 'ff_open_clip_history', function() return open_ddu_ff('clip_history') end )

  -- fn["ddu#custom#action('kind', 'buffer', 'ff_open_buffer',       { args -> open_ddu_ff('buffer',        false) })
  -- fn["ddu#custom#action('kind', 'buffer', 'ff_open_mrw',          { args -> open_ddu_ff('mrw',           false) })
  -- fn["ddu#custom#action('kind', 'buffer', 'ff_open_mrw_current',  { args -> open_ddu_ff('mrw_current',   false) })
  -- fn["ddu#custom#action('kind', 'buffer', 'ff_open_emoji',        { args -> open_ddu_ff('emoji',         false) })
  -- fn["ddu#custom#action('kind', 'buffer', 'ff_open_clip_history', { args -> open_ddu_ff('clip_history',  true) })

  -- fn["ddu#custom#action('kind', 'mrw', 'ff_open_buffer',       { args -> open_ddu_ff('buffer',        false) })
  -- fn["ddu#custom#action('kind', 'mrw', 'ff_open_mrw',          { args -> open_ddu_ff('mrw',           false) })
  -- fn["ddu#custom#action('kind', 'mrw', 'ff_open_mrw_current',  { args -> open_ddu_ff('mrw_current',   false) })
  -- fn["ddu#custom#action('kind', 'mrw', 'ff_open_emoji',        { args -> open_ddu_ff('emoji',         false) })
  -- fn["ddu#custom#action('kind', 'mrw', 'ff_open_clip_history', { args -> open_ddu_ff('clip_history',  true) })
  -- 
  fn["ddu#custom#action"]('kind', 'word', 'ff_open_buffer',       function() return open_ddu_ff('buffer') end)
  fn["ddu#custom#action"]('kind', 'word', 'ff_open_mrw',          function() return open_ddu_ff('mrw') end)
  fn["ddu#custom#action"]('kind', 'word', 'ff_open_mrw_current',  function() return open_ddu_ff('mrw_current') end)
  fn["ddu#custom#action"]('kind', 'word', 'ff_open_emoji',        function() return open_ddu_ff('emoji') end)
  fn["ddu#custom#action"]('kind', 'word', 'ff_open_clip_history', function() return open_ddu_ff('clip_history') end)

  if fn.has('win32') then
    fn["ddu#custom#action"]('kind', 'windows-clipboard-history', 'ff_open_buffer',       function() return open_ddu_ff('buffer') end)
    fn["ddu#custom#action"]('kind', 'windows-clipboard-history', 'ff_open_mrw',          function() return open_ddu_ff('mrw') end)
    fn["ddu#custom#action"]('kind', 'windows-clipboard-history', 'ff_open_mrw_current',  function() return open_ddu_ff('mrw_current') end)
    fn["ddu#custom#action"]('kind', 'windows-clipboard-history', 'ff_open_emoji',        function() return open_ddu_ff('emoji') end)
    fn["ddu#custom#action"]('kind', 'windows-clipboard-history', 'ff_open_clip_history', function() return open_ddu_ff('clip_history') end)
  end

  local function ddu_ff_my_settings()
    vim.keymap.set("n", "z", function() return fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_buffer',       quit = true }) end, { buffer = true, silent = true })
    vim.keymap.set("n", "x", function() return fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_mrw',          quit = true }) end, { buffer = true, silent = true })
    vim.keymap.set("n", "c", function() return fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_mrw_current',  quit = true }) end, { buffer = true, silent = true })
    vim.keymap.set("n", "v", function() return fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_emoji',        quit = true }) end, { buffer = true, silent = true })

    if fn.has('win32') then
      vim.keymap.set("n", "b", function() return fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_clip_history', quit = true }) end, { buffer = true, silent = true })
    end
    -- nnoremap <buffer><silent>   <F12> <Cmd>fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_buffer',       'quit': true })<CR>
    -- nnoremap <buffer><silent>   <F11> <Cmd>fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_mrw',          'quit': true })<CR>
    -- nnoremap <buffer><silent>   <F10> <Cmd>fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_mrw_current',  'quit': true })<CR>
    -- nnoremap <buffer><silent>   <F9>  <Cmd>fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_emoji',        'quit': true })<CR>
    -- if has('win32')
    --   nnoremap <buffer><silent> <F8>  <Cmd>fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_clip_history', 'quit': true })<CR>
    -- end

    vim.keymap.set("n", "<CR>",     function() return fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_mychoosewin', quit = true }) end, { buffer = true, silent = true })
    vim.keymap.set("n", "<Space>",  function() return fn["ddu#ui#ff#do_action"]('toggleSelectItem')                                     end, { buffer = true, silent = true })
    vim.keymap.set("n", "i",        function() return fn["ddu#ui#ff#do_action"]('openFilterWindow')                                     end, { buffer = true, silent = true })
    vim.keymap.set("n", "P",        function() return fn["ddu#ui#ff#do_action"]('preview')                                              end, { buffer = true, silent = true })
    vim.keymap.set("n", "q",        function() return fn["ddu#ui#ff#do_action"]('quit')                                                 end, { buffer = true, silent = true })
    vim.keymap.set("n", "l",        function() return fn["ddu#ui#ff#do_action"]('itemAction', { name = 'open', params = { command = 'vsplit'}, quit = true }) end, { buffer = true, silent = true, expr = true })
    vim.keymap.set("n", "L",        function() return fn["ddu#ui#ff#do_action"]('itemAction', { name = 'open', params = { command = 'split'},  quit = true }) end, { buffer = true, silent = true, expr = true })
    vim.keymap.set("n", "d",        function() return fn["ddu#ui#ff#do_action"]('itemAction', { name = 'delete' }) end, { buffer = true, silent = true })

    vim.keymap.set("n", "z",        function() return  end, { buffer = true, silent = true })

  end

  local augroup_id = vim.api.nvim_create_augroup('my_ddu_ff_preference', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
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
    source = {
      {
        name  = 'buffer',
        param = { path = "~" },
      },
    },
    sourceOption = {
      _ = {
        column = { 'icon_filename' },
      },
    },
    kindOption = {
      buffer = {
        defaultAction = 'open',
      },
    },
    uiParam = {
      buffer = vim.g.floating_ddu_ui_params,
    }
  })

  vim.api.nvim_create_user_command('DduBuffer', function() return fn["ddu#start"]({ name = 'buffer' }) end, {})

  --  ddu-source-file_old
  fn["ddu#custom#patch_local"]('file_old', {
    ui = 'ff',
    source = {
      {
        name  = 'file_old',
        param = {},
      },
    },
    kindOption = {
      file_old = {
        defaultAction = 'open',
      },
    },
    uiParam = {
      file_old = vim.g.floating_ddu_ui_params,
    }
  })

  vim.api.nvim_create_user_command('DduFileOld', function() return fn["ddu#start"]({ name = 'file_old' }) end, {})

  --  ddu-source-emoji
  fn["ddu#custom#patch_local"]('emoji', {
    source = {
      {
        name  = 'emoji',
        param = {},
      },
    },
    kindOption = {
      emoji = {
        defaultAction = 'append',
      },
      word = {
        defaultAction = 'append',
      },
    },
    uiParam = {
      emoji = vim.g.floating_ddu_ui_params,
    }
  })

  vim.api.nvim_create_user_command('DduEmoji', function() return fn["ddu#start"]({ name = 'emoji' }) end, {})

  --  ddu-source-mrw
  local mr_source = {
    name  = 'mr',
    param = { kind = 'mrw' },
  }

  fn["ddu#custom#patch_local"]('mrw', {
    ui = 'ff',
    source = {
      mr_source,
    },
    kindOption = {
      mrw = {
        defaultAction = 'open',
      },
    },
  })

  vim.api.nvim_create_user_command('DduMrw', function() return fn["ddu#start"]({ name = 'mrw' }) end, {})

  local mrw_source = {
    name  = 'mr',
    param ={ kind = 'mrw', current = true },
  }
  fn["ddu#custom#patch_local"]('mrw_current', {
    ui = 'ff',
    source = {
      mrw_source,
    },
    kindOption = {
      mrw = {
        defaultAction = 'open',
      },
    },
  })

  vim.api.nvim_create_user_command('DduMrwCurrent', function() return fn["ddu#start"]({ name = 'mrw_current' }) end, {})


  --  windows-clipboard-history

  if fn.has('win32') then
    fn["ddu#custom#patch_local"]('clip_history', {
      ui = 'ff',
      source = {
        {
          name   = 'windows-clipboard-history',
          param  = { prefix = 'Clip:' },
        }
      },
    })

    vim.api.nvim_create_user_command('DduClip', function() return fn["ddu#start"]({ name = 'clip_history' }) end, {})
  end

  utils.end_debug('ddu ff')
end

local function ddu_filer()
  utils.begin_debug('ddu filer')
  --
  fn["ddu#custom#action"]('kind', 'file', 'open_filer1', function() return show_ddu_filer(0) end)
  fn["ddu#custom#action"]('kind', 'file', 'open_filer2', function() return show_ddu_filer(1) end)
  fn["ddu#custom#action"]('kind', 'file', 'open_filer3', function() return show_ddu_filer(2) end)
  fn["ddu#custom#action"]('kind', 'file', 'open_filer4', function() return show_ddu_filer(3) end)

  local function ddu_filer_my_settings()
    -- basic actions
    vim.keymap.set("n", "q", fn["ddu#ui#filer#do_action"]('quit')        , { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "z", fn["ddu#ui#filer#do_action"]('quit')        , { noremap = true, silent = true, buffer = true })
    -- TODO: redraw
    vim.keymap.set("n", "R", fn["ddu#ui#filer#do_action"]('refreshItems'), { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "a", fn["ddu#ui#filer#do_action"]('chooseAction'), { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "P", fn["ddu#ui#filer#do_action"]('preview')     , { noremap = true, silent = true, buffer = true })

    -- change window
    vim.keymap.set("n", "<F5>", fn["ddu#ui#filer#do_action"]('itemAction', { name = 'open_filer1', params = { id = 0 }, quit = true }), { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "<F6>", fn["ddu#ui#filer#do_action"]('itemAction', { name = 'open_filer2', params = { id = 1 }, quit = true }), { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "<F7>", fn["ddu#ui#filer#do_action"]('itemAction', { name = 'open_filer3', params = { id = 2 }, quit = true }), { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "<F8>", fn["ddu#ui#filer#do_action"]('itemAction', { name = 'open_filer4', params = { id = 3 }, quit = true }), { noremap = true, silent = true, buffer = true })

    -- change directory (path)
    vim.keymap.set("n", "<CR>", function()
      return fn["ddu#ui#get_item"]():get('isTree', false)
      and  fn["ddu#ui#filer#do_action"]('itemAction', { name = 'narrow'})
      or   fn["ddu#ui#filer#do_action"]('itemAction', { name = 'filer_mychoosewin', quit = true })
    end, { noremap = true, silent = true, buffer = true, expr = true })
    vim.keymap.set("n", "h", function()
      return fn["ddu#ui#get_item"]():get('isTree', false)
      and  fn["ddu#ui#filer#do_action"]('collapseItem')
      or   fn.echoe('cannot close this item')
    end, { noremap = true, silent = true, buffer = true, expr = true })
    vim.keymap.set("n", "l", function()
      return fn["ddu#ui#get_item"]():get('isTree', false)
      and fn["ddu#ui#filer#do_action"]('expandItem')
      or  fn["ddu#ui#filer#do_action"]('itemAction', { name = 'open', params = { command = 'vsplit' } })
    end, { noremap = true, silent = true, buffer = true, expr = true })
    vim.keymap.set("n", "L", function()
      return fn["ddu#ui#get_item"]():get('isTree', false)
      and fn["ddu#ui#filer#do_action"]('expandItem')
      or  fn["ddu#ui#filer#do_action"]('itemAction', { name = 'open', params = { command = 'split' } })
    end, { noremap = true, silent = true, buffer = true, expr = true })

    -- change directory aliases
    vim.keymap.set("n", "^",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "narrow", params = { path = fn.expand(vim.g.my_initvim_path) } }) end, { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "|",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "narrow", params = { path = fn.expand("~/repos") } })             end, { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "~",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "narrow", params = { path = fn.expand("~/Documents") } })         end, { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "<BS>", function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "narrow", params = { path = ".." } })                                 end, { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "C",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "cd" })                                                               end, { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "c",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "copy" })                                                             end, { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "x",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "cut" })                                                              end, { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "p",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "paste" })                                                            end, { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "m",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "move" })                                                             end, { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "b",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "newFile" })                                                          end, { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "B",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "newDirectory" })                                                     end, { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "y",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "yank" })                                                             end, { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "d",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "delete" })                                                           end, { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "r",    function() return fn["ddu#ui#filer#do_action"]('itemAction', { name = "rename" })                                                           end, { noremap = true, silent = true, buffer = true })
  end

  local ddu_filer_sources = {
    {
      name = 'file',
      param = {},
    },
  }
  local ddu_filer_source_options = {
    _ = {
      column = { 'icon_filename' },
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

  vim.g.floating_ddu_ui_params_default = vim.g.floating_ddu_ui_params
  vim.g.floating_ddu_ui_params_default.border = "rounded"
  vim.g.floating_ddu_ui_params_default.search = fn.expand('%:p')
  vim.g.floating_ddu_ui_params_default.sort = 'filename'
  vim.g.floating_ddu_ui_params_default.sortTreesFirst = true
  vim.g.floating_ddu_ui_params_default.splitDirection = "topleft"

  local ddu_filer_ui_params = {
    _ = vim.g.floating_ddu_ui_params_default,
    filer = vim.g.floating_ddu_ui_params_default,
    icon_filename = {
      span = 2,
      padding = 2,
      iconWidth = 2,
      useLinkIcon = "grayout",
      sort = 'filename',
      sortTreesFirst = true,
    }
  }

  local ddu_filer_params = #{
    ui = 'filer',
    source = ddu_filer_sources,
    sourceOption = ddu_filer_source_options,
    kindOption = ddu_filer_kind_options,
    actionOption = ddu_filer_action_options,
    uiParam = ddu_filer_ui_params,
  }

  fn["ddu#custom#patch_local"]('filer_1', {
    ui            = 'filer',
    name          = 'filer_1',
    source        = ddu_filer_sources,
    sourceOption  = ddu_filer_source_options,
    kindOption    = ddu_filer_kind_options,
    actionOption  = ddu_filer_action_options,
    uiParam       = ddu_filer_ui_params,
  })
  fn["ddu#custom#patch_local"]('filer_2', {
    ui            = 'filer',
    name          = 'filer_2',
    source        = ddu_filer_sources,
    sourceOption  = ddu_filer_source_options,
    kindOption    = ddu_filer_kind_options,
    actionOption  = ddu_filer_action_options,
    uiParam       = ddu_filer_ui_params,
  })
  fn["ddu#custom#patch_local"]('filer_3', {
    ui            = 'filer',
    name          = 'filer_3',
    source        = ddu_filer_sources,
    sourceOption  = ddu_filer_source_options,
    kindOption    = ddu_filer_kind_options,
    actionOption  = ddu_filer_action_options,
    uiParam       = ddu_filer_ui_params,
  })
  fn["ddu#custom#patch_local"]('filer_4', {
    ui            = 'filer',
    name          = 'filer_4',
    source        = ddu_filer_sources,
    sourceOption  = ddu_filer_source_options,
    kindOption    = ddu_filer_kind_options,
    actionOption  = ddu_filer_action_options,
    uiParam       = ddu_filer_ui_params,
  })

  vim.g.floating_ddu_ui_params_4preference = vim.g.floating_ddu_ui_params_default
  vim.g.floating_ddu_ui_params_4preference.search = fn.expand(vim.g.my_initvim_path)
  --
  fn["ddu#custom#action"]('kind', 'file', 'filer_mychoosewin', function(args) return MyDduChooseWin(1, args) end)

  local augroup_id = vim.api.nvim_create_augroup('my_ddu_ff_preference', { clear = true })
  vim.api.nvim_create_autocmd({ 'TabEnter', 'WinEnter', 'CursorHold', 'FocusGained' }, {
    group = augroup_id,
    pattern = "*",
    callback = function ()
      fn["ddu#ui#filer#do_action"]('checkItems')
    end
  })
  vim.api.nvim_create_autocmd('FileType', {
    group = augroup_id,
    pattern = { "ddu-filer" },
    callback = function ()
      ddu_filer_my_settings()
    end
  })

  vim.api.nvim_create_user_command("DduFiler", function() return show_ddu_filer(current_filer) end, {})
  -- vim.keymap.set("n", "z", function() return show_ddu_filer(current_filer) end, { noremap = true })

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
    event = { 'VimEnter' },
    config = function()
      ddu_basic()
      ddu_ff()
      ddu_filer()
    end,
    keys = {
      { "z", function() return show_ddu_filer(current_filer) end, mode = "n" },
      { "Z", function() return show_ddu_ff() end,                 mode = "n" },
    },
  },
}
