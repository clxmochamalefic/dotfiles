local function win_all()
  return vim.fn.range(1, vim.fn.winnr('$'))
end

local function MyDduChooseWin(src, args)
  TryCatch {
    try = function()
      local path = args[0].action.path
      vim.fn["choosewin#start"](win_all(), {auto_choose = true, hook_enable = false })
      vim.fn.execute('edit ' + path)
    end,
    catch = function()
      if src == 0 then
        -- call ddu#ui#ff#do_action('itemAction')
        vim.fn["ddu#ui#ff#do_action"]('itemAction', args)
      else
        -- call ddu#ui#filer#do_action('itemAction')
        vim.fn["ddu#ui#filer#do_action"]('itemAction', args)
      end
    end
  }
end

local function ddu_basic()
  if vim.g.is_enable_my_debug then
    vim.fn.echo("begin /plugins/ddu.vim load")
  end

  vim.g.ddu_float_window_col            = vim.g.float_window_col
  vim.g.ddu_float_window_row            = vim.g.float_window_row
  vim.g.ddu_float_window_width          = vim.g.float_window_width
  vim.g.ddu_float_window_height         = vim.g.float_window_height
  vim.g.ddu_float_window_preview_width  = 120
  vim.g.ddu_float_window_preview_col    = 0
  vim.g.ddu_float_window_preview_height = vim.g.ddu_float_window_height

  vim.g.floating_ddu_ui_params = {
    span = 2,

    split = 'floating',
    floatingBorder = 'rounded',
    filterFloatingPosition = 'bottom',
    filterSplitDirection = 'floating',
    winRow = vim.g.ddu_float_window_row,
    winCol = vim.g.ddu_float_window_col,
    winWidth = vim.g.ddu_float_window_width,
    winHeight = vim.g.ddu_float_window_height,

    previewFloating = true,
    previewVertical = true,
    previewFloatingBorder = 'rounded',
    previewFloatingZindex = 10000,
    previewCol = vim.g.ddu_float_window_preview_col,
    previewWidth = vim.g.ddu_float_window_preview_width,
    previewHeight = vim.g.ddu_float_window_preview_height,
  }

  --  ddu.vim ------------------------------
  vim.fn["ddu#custom#patch_global"]({
    ui = 'ff',
    sources = {
      { name = 'file_rec', params = #{} },
      { name = 'file' },
      { name = 'buffer' },
      { name = 'emoji' },
    },
    sourceOptions = #{
      "_"; {
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
      file = { defaultAction = 'open', },
      file_old = { defaultAction = 'open', },
      file_rec = { defaultAction = 'open', },
      action = { defaultAction = 'do', },
      word = { defaultAction = 'append', },
      dein_update = { defaultAction = 'viewDiff', },
      "custom-list"; { defaultAction = 'callback', },
    },
    uiParams = #{
      "_"; vim.g.floating_ddu_ui_params,
    },
    actionOptions = {
      echo =     { quit = false, },
      echoDiff = { quit = false, },
    },
  })


  --  ddu-ui --------------------

  --  ddu-ui-ff
  if vim.fn.has('macunix') then
    vim.fn.command("brew install desktop-file-utils")
  end

  if vim.g.is_enable_my_debug then
    echo "begin /plugins/ddu.vim end"
  end

end

local function ddu_ff()
  if vim.g.is_enable_my_debug then
    vim.fn.echo "begin /plugins/ff.ddu.vim load"
  end

  vim.fn["ddu#custom#action"]('kind', 'file', 'ff_mychoosewin', function(args) return MyDduChooseWin(0, args) end)
  local current_ff_name = 'buffer'

  vim.fn.command("DduFF", vim.fn["ddu#start"]({ name = current_ff_name }))
  vim.keymap.set("n", "Z", ":<C-u>DduFF<CR>", { noremap = true })


  local function OpenDduFF(name)
    -- if a:isRequireWin && !has('win32')
    --   return
    -- end

    vim.fn.echom(name)
    -- let current_ff_name = a:name
    vim.fn["ddu#start"]({ name = name })
  end

  vim.fn["ddu#custom#action"]('kind', 'file', 'ff_open_buffer',       function() return OpenDduFF('buffer') end )
  vim.fn["ddu#custom#action"]('kind', 'file', 'ff_open_mrw',          function() return OpenDduFF('mrw') end )
  vim.fn["ddu#custom#action"]('kind', 'file', 'ff_open_mrw_current',  function() return OpenDduFF('mrw_current') end )
  vim.fn["ddu#custom#action"]('kind', 'file', 'ff_open_emoji',        function() return OpenDduFF('emoji') end )
  vim.fn["ddu#custom#action"]('kind', 'file', 'ff_open_clip_history', function() return OpenDduFF('clip_history') end )

  -- vim.fn["ddu#custom#action('kind', 'buffer', 'ff_open_buffer',       { args -> OpenDduFF('buffer',        false) })
  -- vim.fn["ddu#custom#action('kind', 'buffer', 'ff_open_mrw',          { args -> OpenDduFF('mrw',           false) })
  -- vim.fn["ddu#custom#action('kind', 'buffer', 'ff_open_mrw_current',  { args -> OpenDduFF('mrw_current',   false) })
  -- vim.fn["ddu#custom#action('kind', 'buffer', 'ff_open_emoji',        { args -> OpenDduFF('emoji',         false) })
  -- vim.fn["ddu#custom#action('kind', 'buffer', 'ff_open_clip_history', { args -> OpenDduFF('clip_history',  true) })

  -- vim.fn["ddu#custom#action('kind', 'mrw', 'ff_open_buffer',       { args -> OpenDduFF('buffer',        false) })
  -- vim.fn["ddu#custom#action('kind', 'mrw', 'ff_open_mrw',          { args -> OpenDduFF('mrw',           false) })
  -- vim.fn["ddu#custom#action('kind', 'mrw', 'ff_open_mrw_current',  { args -> OpenDduFF('mrw_current',   false) })
  -- vim.fn["ddu#custom#action('kind', 'mrw', 'ff_open_emoji',        { args -> OpenDduFF('emoji',         false) })
  -- vim.fn["ddu#custom#action('kind', 'mrw', 'ff_open_clip_history', { args -> OpenDduFF('clip_history',  true) })
  -- 
  vim.fn["ddu#custom#action"]('kind', 'word', 'ff_open_buffer',       function() return OpenDduFF('buffer') end)
  vim.fn["ddu#custom#action"]('kind', 'word', 'ff_open_mrw',          function() return OpenDduFF('mrw') end)
  vim.fn["ddu#custom#action"]('kind', 'word', 'ff_open_mrw_current',  function() return OpenDduFF('mrw_current') end)
  vim.fn["ddu#custom#action"]('kind', 'word', 'ff_open_emoji',        function() return OpenDduFF('emoji') end)
  vim.fn["ddu#custom#action"]('kind', 'word', 'ff_open_clip_history', function() return OpenDduFF('clip_history') end)

  if vim.fn.has('win32') then
    vim.fn["ddu#custom#action"]('kind', 'windows-clipboard-history', 'ff_open_buffer',       function() return OpenDduFF('buffer') end)
    vim.fn["ddu#custom#action"]('kind', 'windows-clipboard-history', 'ff_open_mrw',          function() return OpenDduFF('mrw') end)
    vim.fn["ddu#custom#action"]('kind', 'windows-clipboard-history', 'ff_open_mrw_current',  function() return OpenDduFF('mrw_current') end)
    vim.fn["ddu#custom#action"]('kind', 'windows-clipboard-history', 'ff_open_emoji',        function() return OpenDduFF('emoji') end)
    vim.fn["ddu#custom#action"]('kind', 'windows-clipboard-history', 'ff_open_clip_history', function() return OpenDduFF('clip_history') end)
  end

  local function ddu_ff_my_settings()
    vim.keymap.set("n", "z", function() return vim.fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_buffer',       quit = true }) end, { buffer = true, silent = true })
    vim.keymap.set("n", "x", function() return vim.fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_mrw',          quit = true }) end, { buffer = true, silent = true })
    vim.keymap.set("n", "c", function() return vim.fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_mrw_current',  quit = true }) end, { buffer = true, silent = true })
    vim.keymap.set("n", "v", function() return vim.fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_emoji',        quit = true }) end, { buffer = true, silent = true })

    if vim.fn.has('win32') then
      vim.keymap.set("n", "b", function() return vim.fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_open_clip_history', quit = true }) end, { buffer = true, silent = true })
    end
    -- nnoremap <buffer><silent>   <F12> <Cmd>vim.fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_buffer',       'quit': true })<CR>
    -- nnoremap <buffer><silent>   <F11> <Cmd>vim.fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_mrw',          'quit': true })<CR>
    -- nnoremap <buffer><silent>   <F10> <Cmd>vim.fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_mrw_current',  'quit': true })<CR>
    -- nnoremap <buffer><silent>   <F9>  <Cmd>vim.fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_emoji',        'quit': true })<CR>
    -- if has('win32')
    --   nnoremap <buffer><silent> <F8>  <Cmd>vim.fn["ddu#ui#filer#do_action('itemAction', { 'name': 'open_clip_history', 'quit': true })<CR>
    -- end

    vim.keymap.set("n", "<CR>",     function() return vim.fn["ddu#ui#ff#do_action"]('itemAction', { name = 'ff_mychoosewin', quit = true }) end, { buffer = true, silent = true })
    vim.keymap.set("n", "<Space>",  function() return vim.fn["ddu#ui#ff#do_action"]('toggleSelectItem')                                     end, { buffer = true, silent = true })
    vim.keymap.set("n", "i",        function() return vim.fn["ddu#ui#ff#do_action"]('openFilterWindow')                                     end, { buffer = true, silent = true })
    vim.keymap.set("n", "P",        function() return vim.fn["ddu#ui#ff#do_action"]('preview')                                              end, { buffer = true, silent = true })
    vim.keymap.set("n", "q",        function() return vim.fn["ddu#ui#ff#do_action"]('quit')                                                 end, { buffer = true, silent = true })
    vim.keymap.set("n", "l",        function() return vim.fn["ddu#ui#ff#do_action"]('itemAction', { name = 'open', params = { command = 'vsplit'}, quit = true }) end, { buffer = true, silent = true, expr = true })
    vim.keymap.set("n", "L",        function() return vim.fn["ddu#ui#ff#do_action"]('itemAction', { name = 'open', params = { command = 'split'},  quit = true }) end, { buffer = true, silent = true, expr = true })
    vim.keymap.set("n", "d",        function() return vim.fn["ddu#ui#ff#do_action"]('itemAction', { name = 'delete' }) end, { buffer = true, silent = true })

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
  vim.fn["ddu#custom#patch_local"]('buffer', {
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

  vim.fn.command("DduBuffer", vim.fn["ddu#start"]({ name = 'buffer' }))

  --  ddu-source-file_old
  vim.fn["ddu#custom#patch_local"]('file_old', {
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

  vim.fn.command("DduFileOld", vim.fn["ddu#start"]({ name = 'file_old' }))

  --  ddu-source-emoji
  vim.fn["ddu#custom#patch_local"]('emoji', {
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

  vim.fn.command("DduEmoji", vim.fn["ddu#start"]({ name = 'emoji' }))

  --  ddu-source-mrw
  local mr_source = {
    name  = 'mr',
    param = { kind = 'mrw' },
  }

  vim.fn["ddu#custom#patch_local"]('mrw', {
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

  vim.fn.command("DduMrw", vim.fn["ddu#start"]({ name = 'mrw' }))

  local mrw_source = {
    name  = 'mr',
    param ={ kind = 'mrw', current = true },
  }
  vim.fn["ddu#custom#patch_local"]('mrw_current', {
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

  vim.fn.command("DduMrwCurrent", vim.fn["ddu#start"]({ name = 'mrw_current' }))


  --  windows-clipboard-history

  if vim.fn.has('win32') then
    vim.fn["ddu#custom#patch_local"]('clip_history', {
      ui = 'ff',
      source = {
        {
          name   = 'windows-clipboard-history',
          param  = { prefix = 'Clip:' },
        }
      },
    })

    vim.fn.command("DduClip", vim.fn["ddu#start"]({ name = 'clip_history' }))
  end

  if vim.g.is_enable_my_debug then
    vim.fn.echo("begin /plugins/ff.ddu.vim end")
  end
end

local function ddu_filer()
end

return {
  {
    'Shougo/ddu.vim',
    dependencies = {
      'denops.vim',

      'ddu-ui-ff',
      'ddu-ui-filer',

      'ddu-source-action',
      'ddu-source-buffer',
      'ddu-source-custom-list',
      'ddu-source-dein_update',
      'ddu-source-emoji',
      'ddu-source-file',
      'ddu-source-file_old',
      'ddu-source-file_rec',
      'ddu-source-mr',
      'ddu-source-nvim-lsp',
      'ddu-source-source',

      'ddu-filter-matcher_substring',

      'ddu-kind-file',
      'ddu-kind-word',

      'ddu-column-filename',
      'ddu-column-icon_filename',

      'ddu-vim-ui-select',

      'windows-clipboard-history.vim',
    }
    event = { 'VimEnter' }
    command = function()
      execute "source " . expand(g:my_initvim_path . "/plugins/ddu.vim")
    end
  },
}

