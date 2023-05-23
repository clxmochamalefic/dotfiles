local utils = require("utils")

local function ddc_init()
  utils.begin_debug("ddc_init")

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
    [':'] = { 'cmdline-history', 'around'},
    ['@'] = { 'cmdline-history', 'input', 'file', 'around'},
    ['>'] = { 'cmdline-history', 'input', 'file', 'around'},
    ['/'] = { 'around', 'line'},
    ['?'] = { 'around', 'line'},
    ['-'] = { 'around', 'line'},
    ['='] = { 'input'},
  }

  -- if has('win32')
  --   local sources = add(s:sources, 'windows-clipboard-history')
  -- endif

  -- Use matcher_head and sorter_rank.
  -- https://github.com/Shougo/ddc-matcher_head
  -- https://github.com/Shougo/ddc-sorter_rank
  local source_option_default = {
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
  local source_option_around = {
    mark        = '   ',
    isVolatile  = true,
    matchers    = {'matcher_fuzzy'},
    sorters     = {'sorter_fuzzy'},
    converters  = {'converter_fuzzy'},
    maxItems    = 8,
  }
  local source_option_buffer = {
    mark        = '   ',
    isVolatile  = true,
    matchers    = {'matcher_fuzzy'},
    sorters     = {'sorter_fuzzy'},
    converters  = {'converter_fuzzy'},
  }
  local source_option_file = {
    mark                    = '   ',
    forceCompletionPattern  = '[\\w@:~._-]/[\\w@:~._-]*',
    minAutoCompleteLength   = 2,
    sorters                 = {'sorter_fuzzy'},
  }
  local source_option_nvimlsp = {
    mark                    = '   ',
    isVolatile              = true,
    forceCompletionPattern  = '\\.\\w*|:\\w*|->\\w*',
    matchers                = {'matcher_fuzzy'},
    sorters                 = {'sorter_fuzzy'},
    converters              = {'converter_fuzzy'}
  }
  local source_option_omni = {
    mark = '   ',
  }
  local source_option_skkeleton = {
    mark        = ' 🎌 ',
    isVolatile  = true,
    matchers    = {'skkeleton'},
    sorters     = {},
  }

  -- local source_option_path = {
  --   mark = '   ',
  --   forceCompletionPattern = '[\\w@:~._-]/[\\w@:~._-]*',
  --   minAutoCompleteLength = 2,
  --   sorters = ['sorter_fuzzy'],
  -- }
  local source_option_vsnip = {
    mark        = '   ',
    dup         = true,
    matchers    = {'matcher_fuzzy'},
    sorters     = {'sorter_fuzzy'},
    converters  = {'converter_fuzzy'}
  }
  local source_option_cmdlinehistory = {
    mark        = '   ',
    isVolatile  = true,
    matchers    = {'matcher_fuzzy'},
    sorters     = {'sorter_fuzzy'},
    converters  = {'converter_fuzzy'}
  }
  local source_option_shellhistory = {
    mark              = '   ',
    isVolatile        = true,
    minKeywordLength  = 2,
    maxKeywordLength  = 50,
    matchers          = {'matcher_fuzzy'},
    sorters           = {'sorter_fuzzy'},
    converters        = {'converter_fuzzy'}
  }
  local source_options = {
    ["_"]               = source_option_default,
    ["around"]          = source_option_around,
    ['buffer']          = source_option_buffer,
    ['file']            = source_option_file,
    ["nvim-lsp"]        = source_option_nvimlsp,
    ["omni"]            = source_option_omni,
    ['vsnip']           = source_option_vsnip,
    ["cmdline-history"] = source_option_cmdlinehistory,
    ["shell-history"]   = source_option_shellhistory,
  }


  -- if has('win32')
  --   local source_options["windows-clipboard-history"] = { mark"; '', }
  -- endif

  local source_params_around = {
    maxSize = 500,
  }

  local source_params_buffer = {
    requireSameFiletype = false,
    fromAltBuf          = true,
    bufNameStyle        = 'basename',
  }

  local source_params_file = {
    trailingSlash   = true,
    followSymlinks  = true,
  }

  local source_params_nvimlsp = {
    maxSize =    20,
  }

  local source_params = {
    ['around']   = source_params_around,
    ['buffer']   = source_params_buffer,
    ['file']     = source_params_file,
    ['nvim-lsp'] = source_params_nvimlsp,
  }
  -- sourceParams['path'] = {
  --   "cmd"; {'fd', '--max-depth', '5'},
  -- }

  -- if vim.fn.has('win32') then
  --   source_params["windows-clipboard-history"] = {
  --     "maxSize"; 100,
  --     "maxAbbrWidth"; 100,
  --   }
  -- end

  local filter_params_matcher_fuzzy = {
    splitMode = 'word'
  }

  local filter_params_converter_fuzzy = {
    hlGroup = 'SpellBad'
  }

  local filter_params_truncate = {
    maxAbbrWidth = 40,
    maxInfoWidth = 40,
    maxKindWidth = 20,
    maxMenuWidth = 20,
    ellipsis = '..',
  }

  local filter_params = {
    ['matcher_fuzzy']       = filter_params_matcher_fuzzy,
    ['converter_fuzzy']     = filter_params_converter_fuzzy,
    ["converter_truncate"]  = filter_params_truncate,
  }


  -- --  Filetype
  -- vim.fn["ddc#custom#patch_filetype"]({'toml'}, {
  --   sourceOptions = {
  --     ["nvim-lsp"] = { forceCompletionPattern = '\\.|[={[,"]\\s*' },
  --   }
  -- })

  -- vim.fn["ddc#custom#patch_filetype"](
  -- {
  --   'python', 'typescript', 'typescriptreact', 'rust', 'markdown', 'yaml',
  --   'json', 'sh', 'lua', 'toml', 'go'
  -- }, {
  --   sources = { ['nvim-lsp'] = sources },
  -- })


  local autocomplete_events  = {
    'InsertEnter',  'TextChangedI', 'TextChangedP',
    'CmdlineEnter', 'CmdlineChanged',
  }
  --  integrate preferences.
  local patch_global = {
    sources             = sources,
    cmdlineSources      = cmd_sources,
    sourceOptions       = source_options,
    sourceParams        = source_params,
    filterParams        = filter_params,
    backspaceCompletion = true,
    autoCompleteEvents  = autocomplete_events,
    ui                  = 'pum',
  }

  vim.fn["ddc#custom#patch_global"](patch_global)

  --  use ddc.
  vim.fn["ddc#enable"]()

  utils.end_debug("ddc_init")
end

local function ddc_preference()
  utils.begin_debug("ddc_preference")

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

  vim.keymap.set('i', '<C-l>',      function() return vim.fn["ddc#map#extend"]() end,                 { silent = true, expr = true, noremap = true })
  vim.keymap.set('i', '<C-x><C-f>', function() return vim.fn["ddc#map#manual_complete"]('path') end,  { silent = true, expr = true, noremap = true })

  --  skkeleton
  local skkeleton_dir = vim.fn.expand('~/.cache/.skkeleton')
  if vim.fn.isdirectory(skkeleton_dir) ~= 1 then
    vim.fn.mkdir(skkeleton_dir, 'p')
  end

  vim.fn["skkeleton#config"]({ completionRankFile = '~/.cache/.skkeleton/rank.json' })

  utils.end_debug("ddc_preference")
end

local function snippet_preference()
  utils.begin_debug("snippet_preference")

  vim.keymap.set('i', '<Tab>',    function() return vim.fn["vsnip#available"](1) and '<Plug>(vsnip-expand-or-jump)' or '<Tab>' end, { expr = true })
  vim.keymap.set('s', '<Tab>',    function() return vim.fn["vsnip#available"](1) and '<Plug>(vsnip-expand-or-jump)' or '<Tab>' end, { expr = true })
  vim.keymap.set('i', '<S-Tab>',  function() return vim.fn["vsnip#jumpable"](-1) and '<Plug>(vsnip-jump-prev)' or '<S-Tab>' end,    { expr = true })
  vim.keymap.set('s', '<S-Tab>',  function() return vim.fn["vsnip#jumpable"](-1) and '<Plug>(vsnip-jump-prev)' or '<S-Tab>' end,    { expr = true })

  utils.end_debug("snippet_preference")
end


return {
  'Shougo/ddc.vim',
  lazy = true,
  event = { 'InsertEnter', 'CursorHold' },
  dependencies = {
    'vim-denops/denops.vim',

    'Shougo/pum.vim',
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

    'vim-skk/skkeleton',

    {
      'matsui54/denops-popup-preview.vim',
      dependencies = { 'vim-denops/denops.vim', },
      lazy = true,
      event = 'LspAttach',
      config = function()
        vim.g.popup_preview_config = {
          delay = 10,
          maxWidth = 100,
          winblend = 0,
        }
        vim.fn["popup_preview#enable"]()
      end
    },
    {
      'matsui54/denops-signature_help',
      dependencies = { 'vim-denops/denops.vim', },
      lazy = true,
      event = 'LspAttach',
      config = function()
        vim.fn["signature_help#enable"]()
      end
    },
  },
  init = function()
  end,
  config = function()
    ddc_init()
    ddc_preference()
    snippet_preference()
  end
}

