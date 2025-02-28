local source_params_around = {
  maxSize = 500,
}

local source_params_buffer = {
  requireSameFiletype = false,
  fromAltBuf = true,
  bufNameStyle = "basename",
  limitBytes = 5000000,
  --forceCollect = true,
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

local function get_source_params()
  return {
    ["lsp"] = source_params_nvimlsp(),
    --    ['buffer']   = source_params_buffer,
    ["file"] = source_params_file,
    ["around"] = source_params_around,
  }
end

-- ------------------------

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

local M = {
  src = {},
  filter = filter_params
}

M.src.get = function()
  return get_source_params()
end

return M
