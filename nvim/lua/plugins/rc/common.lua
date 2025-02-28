---@diagnostic disable: undefined-global
-- ---------------------------------------------------------------------------
--  COMMON PLUGINS
-- ---------------------------------------------------------------------------

local myDenops = require("plugins.rc.config.denops")
local pumHelper = require("plugins.rc.helper.pum")

return {
  {
    lazy = false,
    'Shougo/pum.vim',
    config = function()
      pumHelper.setup()
    end
  },
  {
    'kevinhwang91/promise-async'
  },
  {
    'vim-denops/denops.vim',
    build = function()
      myDenops.configure()
      myDenops.setup()
      myDenops.build()
      myDenops.update()
    end,
    config = function()
      myDenops.setup()
      myDenops.configure()
    end,
  },
  {
    -- icon
    lazy = true,
    'nvim-tree/nvim-web-devicons'
  },
  {
    -- completion [{()}]
    'tpope/vim-surround',
    lazy = true,
    condition = true,
    event = { 'BufEnter' }
  },
  {
    -- 現在のカーソル位置のコンテキストによって filetype を切り換える
    'osyo-manga/vim-precious',
    lazy = true,
    condition = false,
    dependencies = { 'Shougo/context_filetype.vim' },
    event = { 'BufEnter' }
  },
  {
    -- vimplugin のヘルプを生成する
    'LeafCage/vimhelpgenerator',
    lazy = true,
    cmd = {
      "VimHelpGenerator",
    }
    --    ft = { 'vimscript', 'lua', 'typescript' }
  },
  {
    -- windows のクリップボード履歴の利用
    lazy = true,
    'Milly/windows-clipboard-history.vim',
    enabled = function() return vim.fn.has("win32") end
  },
  {
    -- かっこの自動補完
    'cohama/lexima.vim',
    lazy = true,
    event = { 'InsertChange' },
    init = function()
      vim.g.lexima_enable_basic_rules   = 1
      vim.g.lexima_enable_newline_rules = 1
      vim.g.lexima_enable_endwise_rules = 1
    end
  },
  {
    -- 連番の自動入力
    lazy = true,
    'deris/vim-rengbang',
    event = { 'InsertChange' },
    init = function()
      -- Following settings is default value.
      vim.g.rengbang_default_pattern          = '\\(\\d\\+\\)'
      vim.g.rengbang_default_start            = 0
      vim.g.rengbang_default_step             = 1
      vim.g.rengbang_default_usefirst         = 0
      vim.g.rengbang_default_confirm_sequence = {
        'pattern',
        'start',
        'step',
        'usefirst',
        'format',
      }
    end
  },
  {
    lazy = true,
    'haya14busa/vim-asterisk',
    event = { 'FileReadPost', 'InsertLeave' },
    config = function()
      vim.g["asterisk#keeppos"] = 1
      vim.keymap.set('n', "*", "<Plug>(asterisk-z*)")
      vim.keymap.set('n', "#", "<Plug>(asterisk-z#)")
      vim.keymap.set('n', "g*", "<Plug>(asterisk-gz*)")
      vim.keymap.set('n', "g#", "<Plug>(asterisk-gz#)")
    end
  },
  {
    lazy = true,
    "nvim-lua/plenary.nvim",
    build =
    "npm install -g textlint textlint-rule-prh textlint-rule-preset-jtf-style textlint-rule-preset-ja-technical-writing textlint-rule-terminology textlint-rule-preset-ja-spacing",
  },
}
