-- Customize global settings
-- Use around source.
-- https://github.com/Shougo/ddc-around
local function sources()
  return {
    --    'tsnip',
    "lsp",
    --    'buffer',
    "file",
    "vsnip",
    "skkeleton",
    "around",
  }
end

local cmd_sources = {
  [":"] = { "cmdline-history", "around" },
  ["@"] = { "cmdline-history", "input", "file", "around" },
  [">"] = { "cmdline-history", "input", "file", "around" },
  ["/"] = { "line", "around" },
  ["?"] = { "line", "around" },
  ["-"] = { "line", "around" },
  ["="] = { "input" },
}

local ui_params = {
  pum = { insert = true },
}

-- if has('win32')
--   local sources = add(s:sources, 'windows-clipboard-history')
-- endif

-- Use matcher_head and sorter_rank.
-- https://github.com/Shougo/ddc-matcher_head
-- https://github.com/Shougo/ddc-sorter_rank
local source_option_default = {
  mark = "   ",
  ignoreCase = true,
  matchers = { "matcher_fuzzy" },
  sorters = { "sorter_fuzzy" },
  converters = {
    "converter_remove_overlap",
    "converter_truncate",
    "converter_fuzzy",
  },
  maxItems = 10,
}
local source_option_around = {
  mark = "   ",
  isVolatile = true,
  matchers = { "matcher_fuzzy" },
  sorters = { "sorter_fuzzy" },
  converters = { "converter_fuzzy" },
  maxItems = 8,
}
local source_option_buffer = {
  mark = "   ",
  isVolatile = true,
  matchers = { "matcher_fuzzy" },
  sorters = { "sorter_fuzzy" },
  converters = { "converter_fuzzy" },
}
local source_option_file = {
  mark = "   ",
  forceCompletionPattern = "[\\w@:~._-]/[\\w@:~._-]*",
  minAutoCompleteLength = 2,
  sorters = { "sorter_fuzzy" },
}
local source_option_nvimlsp = {
  mark = "   ",
  isVolatile = true,
  forceCompletionPattern = "\\.\\w*|:\\w*|->\\w*",
  matchers = { "matcher_fuzzy" },
  sorters = { "sorter_fuzzy" },
  converters = { "converter_fuzzy" },
}
local source_option_omni = {
  mark = "   ",
}
local source_option_skkeleton = {
  mark = " 🎌 ",
  isVolatile = true,
  matchers = { "skkeleton" },
  sorters = {},
  converters = {},
}

-- local source_option_path = {
--   mark = '   ',
--   forceCompletionPattern = '[\\w@:~._-]/[\\w@:~._-]*',
--   minAutoCompleteLength = 2,
--   sorters = ['sorter_fuzzy'],
-- }
local source_option_vsnip = {
  mark = "   ",
  dup = true,
  matchers = { "matcher_fuzzy" },
  sorters = { "sorter_fuzzy" },
  converters = { "converter_fuzzy" },
}
--  local source_option_tsnip = {
--    mark        = '   ',
--    dup         = true,
--    matchers    = {'matcher_fuzzy'},
--    sorters     = {'sorter_fuzzy'},
--    converters  = {'converter_fuzzy'}
--  }
local source_option_cmdlinehistory = {
  mark = "   ",
  isVolatile = true,
  matchers = { "matcher_fuzzy" },
  sorters = { "sorter_fuzzy" },
  converters = { "converter_fuzzy" },
}
local source_option_shellhistory = {
  mark = "   ",
  isVolatile = true,
  minKeywordLength = 2,
  maxKeywordLength = 50,
  matchers = { "matcher_fuzzy" },
  sorters = { "sorter_fuzzy" },
  converters = { "converter_fuzzy" },
}
local source_options = {
  ["_"] = source_option_default,
  --    ['tsnip']           = source_option_tsnip,
  ["lsp"] = source_option_nvimlsp,
  ["omni"] = source_option_omni,
  --    ['buffer']          = source_option_buffer,
  ["file"] = source_option_file,
  ["vsnip"] = source_option_vsnip,
  ["cmdline-history"] = source_option_cmdlinehistory,
  ["shell-history"] = source_option_shellhistory,

  ["around"] = source_option_around,
  ["skkeleton"] = source_option_skkeleton,
}

-- if has('win32')
--   local source_options["windows-clipboard-history"] = { mark"; '', }
-- endif

local source_params_around = {
  maxSize = 500,
}

local source_params_buffer = {
  requireSameFiletype = false,
  fromAltBuf = true,
  bufNameStyle = "basename",
  limitBytes = 5000000,
  forceCollect = true,
}

local source_params_file = {
  trailingSlash = true,
  followSymlinks = true,
}


local function source_params_nvimlsp()
  return {
    maxSize = 20,
    snippetEngine = vim.fn["denops#callback#register"](function(body)
      vim.fn["vsnip#anonymous"](body)
    end),
    enableResolveItem = true,
    enableAdditionalTextEdit = true,
  }
end

local function source_params()
  return {
    ["lsp"] = source_params_nvimlsp(),
    --    ['buffer']   = source_params_buffer,
    ["file"] = source_params_file,
    ["around"] = source_params_around,
  }
end
-- sourceParams['path'] = {
--   "cmd"; {'fd', '--max-depth', '5'},
-- }

-- if fn.has('win32') then
--   source_params["windows-clipboard-history"] = {
--     "maxSize"; 100,
--     "maxAbbrWidth"; 100

local filter_params_matcher_fuzzy = {
  splitMode = "word",
}

local filter_params_converter_fuzzy = {
  hlGroup = "SpellBad",
}
local filter_params_truncate = {
  maxAbbrWidth = 40,
  maxInfoWidth = 40,
  maxKindWidth = 20,
  maxMenuWidth = 20,
  ellipsis = "..",
}

local filter_params = {
  ["matcher_fuzzy"] = filter_params_matcher_fuzzy,
  ["converter_fuzzy"] = filter_params_converter_fuzzy,
  ["converter_truncate"] = filter_params_truncate,
}

-- --  Filetype
-- fn."ddc#custom#patch_filetype"]({'toml'}, {
--   sourceOptions = {
--     ["lsp"] = { forceCompletionPattern = '\\.|[={[,"]\\s*' },
--   }
-- })

-- fn."ddc#custom#patch_filetype"](
-- {
--   'python', 'typescript', 'typescriptreact', 'rust', 'markdown', 'yaml',
--   'json', 'sh', 'lua', 'toml', 'go'
-- }, {
--   sources = { ['lsp'] = sources },
-- })

local autocomplete_events = {
  "InsertEnter",
  "TextChangedI",
  "TextChangedP",
  "CmdlineEnter",
  "CmdlineChanged",
}
--  integrate preferences.
local M = {}

M.get_config = function()
  return {
    ui = "pum",
    --    uiParams            = ui_params,
    sources = sources(),
    cmdlineSources = cmd_sources,
    sourceOptions = source_options,
    sourceParams = source_params(),
    filterParams = filter_params,
    backspaceCompletion = true,
    autoCompleteEvents = autocomplete_events,
  }
end

return M
