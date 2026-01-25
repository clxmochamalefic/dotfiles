-- ---------------------------------------------------------------------------
-- COLORSCHEME PLUGINS
-- ---------------------------------------------------------------------------

local groups = {
  'Normal',
  'NormalNC',
  'Comment',
  'Constant',
  'Special',
  'Identifier',
  'Statement',
  'PreProc',
  'Type',
  'Underlined',
  'Todo',
  'String',
  'Function',
  'Conditional',
  'Repeat',
  'Operator',
  'Structure',
  'LineNr',
  'NonText',
  'SignColumn',
  'CursorLine',
  'CursorLineNr',
  'StatusLine',
  'StatusLineNC',
  'EndOfBuffer',

  'TelescopeNormal',
  "NotifyBackground",
  "NotifyERRORBody",
  "NotifyWARNBody",
  "NotifyINFOBody",
  "NotifyDEBUGBody",
  "NotifyTRACEBody",
  "NotifyLogTime",
  "NotifyLogTitle",
}

return {
  'cocopon/iceberg.vim',
  'jdkanani/vim-material-theme',
  'ciaranm/inkpot',
  'ryanoasis/vim-devicons',
  {
    'sonph/onehalf',
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/vim")
    end
  },
  {
    'xiyaowong/transparent.nvim',
    opts = {
      -- table: default groups
      groups = groups,
      -- table: additional groups that should be cleared
      extra_groups = {},
      -- table: groups you don't want to clear
      exclude_groups = {},
      -- function: code to be executed after highlight groups are cleared
      -- Also the user event "TransparentClear" will be triggered
      on_clear = function() end,
    },
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/vim")
    end
  },
}

