local sources = require('plugins.plugin.ddc.config.global.source')
local cmd_sources = require('plugins.plugin.ddc.config.global.cmdsource')
local option = require('plugins.plugin.ddc.config.global.option')
local params = require('plugins.plugin.ddc.config.global.params')

-- if has('win32')
--   local sources = add(s:sources, 'windows-clipboard-history')
-- endif


-- if has('win32')
--   local source_options["windows-clipboard-history"] = { mark"; '', }
-- endif

-- sourceParams['path'] = {
--   "cmd"; {'fd', '--max-depth', '5'},
-- }

-- if fn.has('win32') then
--   source_params["windows-clipboard-history"] = {
--     "maxSize"; 100,
--     "maxAbbrWidth"; 100

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
  "CmdlineChanged",
}

--  integrate preferences.
local M = {
  autocomplete_events = autocomplete_events,
}

M.get_config = function()
  return {
    --ui = "native",
    ui = "pum",
    sources = sources,
    cmdlineSources = cmd_sources,
    sourceOptions = option.source_options,
    sourceParams = params.src.get(),
    filterParams = params.filter,
    --specialBufferCompletion = true,
    --backspaceCompletion = true,
    --autoCompleteDelay = 1000,
    --hideOnEvents = true,
    autoCompleteEvents = autocomplete_events,
  }
end

return M
