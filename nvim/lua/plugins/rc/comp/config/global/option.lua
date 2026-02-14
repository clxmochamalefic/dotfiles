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
  --maxItems = 10,
}
local source_option_around = {
  mark = "   ",
  isVolatile = true,
  minAutoCompleteLength = 3,
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
  minAutoCompleteLength = 4,
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
  isVolatile = true,
  matchers = { "matcher_fuzzy" },
  sorters = { "sorter_fuzzy" },
  converters = { "converter_fuzzy" },
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
--   minAutoCompleteLength = 1,
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
  minKeywordLength = 2,
  maxKeywordLength = 50,
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
  --["skkeleton"] = source_option_skkeleton,
}

local filterOptions = {
  matcher_head = {},
}

local M = {
  filterOptions = filterOptions,
  source_options = source_options,
}

return M
