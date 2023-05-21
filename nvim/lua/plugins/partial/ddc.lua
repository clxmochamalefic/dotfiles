local function ddc_preference()
  if vim.g.is_enable_my_debug then
    vim.fn.echo("begin /plugins/ddc.vim load")
  end

  -- Customize global settings
  -- Use around source.
  -- https://github.com/Shougo/ddc-around
  local sources = {
    'around',
    'buffer',
    'file',
    'nvim-lsp',
    'vsnip',
    'skkeleton',
  }

  local cmd_sources = {
    ':'; {'cmdline-history', 'cmdline', 'around'},
    '@'; {'cmdline-history', 'input', 'file', 'around'},
    '>'; {'cmdline-history', 'input', 'file', 'around'},
    '/'; {'around', 'line'},
    '?'; {'around', 'line'},
    '-'; {'around', 'line'},
    '='; {'input'},
  }

  -- if has('win32')
  --   local sources = add(s:sources, 'windows-clipboard-history')
  -- endif

  -- Use matcher_head and sorter_rank.
  -- https://github.com/Shougo/ddc-matcher_head
  -- https://github.com/Shougo/ddc-sorter_rank
  local sourceOptions = {}

  sourceOptions["_"] = {
    mark        = '   ',
    ignoreCase  = true,
    matchers    = {'matcher_fuzzy'},
    sorters     = {'sorter_fuzzy'},
    converters  = {
      'converter_remove_overlap',
      'converter_truncate',
      'converter_fuzzy',
    },
    maxItems    = 10,
  }

  sourceOptions["around"] = {
    mark        = '   ',
    isVolatile  = true,
    matchers    = {'matcher_fuzzy'},
    sorters     = {'sorter_fuzzy'},
    converters  = {'converter_fuzzy'},
    maxItems    = 8,
  }

  sourceOptions['buffer'] = {
    mark        = '   ',
    isVolatile  = true,
    matchers    = {'matcher_fuzzy'},
    sorters     = {'sorter_fuzzy'},
    converters  = {'converter_fuzzy'},
  }

  sourceOptions['file'] = {
    mark                    = '   ',
    forceCompletionPattern  = '[\\w@:~._-]/[\\w@:~._-]*',
    minAutoCompleteLength   = 2,
    sorters                 = {'sorter_fuzzy'},
  }

  sourceOptions["nvim-lsp"] = {
    mark                    = '   ',
    isVolatile              = true,
    forceCompletionPattern  = '\\.\\w*|:\\w*|->\\w*',
    matchers                = {'matcher_fuzzy'},
    sorters                 = {'sorter_fuzzy'},
    converters              = {'converter_fuzzy'}
  }
  sourceOptions["omni"] = {
    mark = '   ',
  }
  sourceOptions["skkeleton"] = {
    mark        = ' 🎌 ',
    isVolatile  = true,
    matchers    = {'skkeleton'},
    sorters     = {},
  }

  -- sourceOptions['path'] = {
  --   mark = '   ',
  --   forceCompletionPattern = '[\\w@:~._-]/[\\w@:~._-]*',
  --   minAutoCompleteLength = 2,
  --   sorters = ['sorter_fuzzy'],
  -- }

  sourceOptions['vsnip'] = {
    mark        = '   ',
    dup         = true,
    matchers    = {'matcher_fuzzy'},
    sorters     = {'sorter_fuzzy'},
    converters  = {'converter_fuzzy'}
  }


  sourceOptions["cmdline-history"] = {
    mark        = '   ',
    isVolatile  = true,
    matchers    = {'matcher_fuzzy'},
    sorters     = {'sorter_fuzzy'},
    converters  = {'converter_fuzzy'}
  }

  sourceOptions["shell-history"] = {
    mark              = '   ',
    isVolatile        = true,
    minKeywordLength  = 2,
    maxKeywordLength  = 50,
    matchers          = {'matcher_fuzzy'},
    sorters           = {'sorter_fuzzy'},
    converters        = {'converter_fuzzy'}
  }

  -- if has('win32')
  --   local source_options["windows-clipboard-history"] = { mark"; '', }
  -- endif

  local sourceParams = {}

  sourceParams['around'] = {
    maxSize = 500,
  }

  sourceParams['buffer'] = {
    requireSameFiletype = false,
    fromAltBuf          = true,
    bufNameStyle        = 'basename',
  }

  sourceParams['file'] = {
    trailingSlash   = true,
    followSymlinks  = true,
  }

  -- sourceParams['path'] = {
  --   "cmd"; {'fd', '--max-depth', '5'},
  -- }

  sourceParams['nvim-lsp'] = {
    maxSize =    20,
  }

  -- if vim.fn.has('win32') then
  --   source_params["windows-clipboard-history"] = {
  --     "maxSize"; 100,
  --     "maxAbbrWidth"; 100,
  --   }
  -- end
  -- 
  local filterParams = {}

  filterParams['matcher_fuzzy'] = {
    splitMode = 'word'
  }

  filterParams['converter_fuzzy'] = {
    hlGroup = 'SpellBad'
  }

  filterParams["converter_truncate"] = {
    maxAbbrWidth = 40,
    maxInfoWidth = 40,
    maxKindWidth = 20,
    maxMenuWidth = 20,
    ellipsis = '..',
  }


  --  Filetype
  vim.fn["ddc#custom#patch_filetype"]({'toml'}, {
    sourceOptions = {
      "nvim-lsp"; { forceCompletionPattern = '\\.|[={[,"]\\s*' },
    }
  })

  vim.fn["ddc#custom#patch_filetype"](
  {
    'python', 'typescript', 'typescriptreact', 'rust', 'markdown', 'yaml',
    'json', 'sh', 'lua', 'toml', 'go'
  }, {
    sources = { 'nvim-lsp'; sources },
  })


  --  integrate preferences.
  local patch_global = {}
  patch_global.sources              = sources
  patch_global.cmdlineSources       = cmd_sources
  patch_global.sourceOptions        = sourceOptions
  patch_global.sourceParams         = sourceParams 
  patch_global.filterParams         = filterParams 
  patch_global.backspaceCompletion  = true

  --  set other preferences
  patch_global.autoCompleteEvents = {
    'InsertEnter', 'TextChangedI', 'TextChangedP',
    'CmdlineEnter', 'CmdlineChanged',
  }
  patch_global.ui = 'pum'

  vim.fn["ddc#custom#patch_global"](patch_global)


  --  Key mappings

  --  For insert mode completion
  vim.keymap.set('i', '<C-n>', '<Cmd>call pum#map#insert_relative(1)<CR>')
  vim.keymap.set('i', '<C-p>', '<Cmd>call pum#map#insert_relative(-1)<CR>')
  vim.keymap.set('i', '<C-e>', '<Cmd>call pum#map#cancel()<CR>')
  vim.keymap.set('i', '<C-y>', '<Cmd>call pum#map#confirm()<CR>')
  vim.keymap.set('i', '<CR>', function() return vim.fn["pum#visible"] == 1 and '<Cmd>call pum#map#confirm()<CR>' or '<CR>' end)
  -- Manually open the completion menu
  vim.keymap.set('i', '<C-Space>', 'ddc#map#manual_complete()', {
    replace_keycodes  = false,
    expr              = true,
    desc              = '[ddc.vim] Manually open popup menu'
  })

  vim.keymap.set('i', '<C-l>', vim.fn["ddc#map#extend"](), { silent = true, expr = true, noremap = true })
  vim.keymap.set('i', '<C-x><C-f>', vim.fn["ddc#map#manual_complete"]('path'), { silent = true, expr = true, noremap = true })


  --  skkeleton
  local skkeleton_dir = vim.fn.expand('~/.cache/.skkeleton')
  if vim.fn.isdirectory(skkeleton_dir) ~= 1 then
    vim.fn.mkdir(skkeleton_dir, 'p')
  end

  vim.fn["skkeleton#config"]({ completionRankFile = '~/.cache/.skkeleton/rank.json' })

  --  use ddc.
  vim.fn["ddc#enable"]()

  if vim.g.is_enable_my_debug then
    vim.fn.echo("end /plugins/ddc.vim load")
  end

end

local function snippet_preference()
  vim.keymap.set(
    'i',
    '<Tab>',
    function() return vim.fn["vsnip#available"](1) and '<Plug>(vsnip-expand-or-jump)' or '<Tab>' end,
    { expr = true }
  )
  vim.keymap.set(
    's',
    '<Tab>',
    function() return vim.fn["vsnip#available"](1) and '<Plug>(vsnip-expand-or-jump)' or '<Tab>' end,
    { expr = true }
  )
  vim.keymap.set(
    'i',
    '<S-Tab>',
    function() return vim.fn["vsnip#jumpable"](-1) and '<Plug>(vsnip-jump-prev)' or '<S-Tab>' end,
    { expr = true }
  )
  vim.keymap.set(
    's',
    '<S-Tab>',
    function() return vim.fn["vsnip#jumpable"](-1) and '<Plug>(vsnip-jump-prev)' or '<S-Tab>' end,
    { expr = true }
  )
end


return {
  'Shougo/ddc.vim',
  lazy = true,
  event = {'InsertEnter', 'CursorHold'},
  dependencies = {
    'vim-denops/denops.vim',
    'pum.vim',
    'Shougo/ddc-ui-pum',
    'Shougo/ddc-source-nvim-lsp',
    'Shougo/ddc-source-around',
    'Shougo/ddc-buffer',
    --  'ddc-dictionary',
    'LumaKernel/ddc-source-file',
    'tani/ddc-fuzzy',
    'Shougo/ddc-cmdline-history',
    'delphinus/ddc-shell-history',
    'Shougo/ddc-matcher_head',
    'Shougo/ddc-source-omni',
    --  'ddc-path',
    'Shougo/ddc-sorter_rank',
    'hrsh7th/vim-vsnip',
    'hrsh7th/vim-vsnip-integ',
    'rafamadriz/friendly-snippets',

    'Shougo/ddc-converter_remove_overlap',
    'matsui54/ddc-converter_truncate',

    'Milly/windows-clipboard-history.vim',
  },
  command = function()
    ddc_preference()
    snippet_preference()
  end
}

