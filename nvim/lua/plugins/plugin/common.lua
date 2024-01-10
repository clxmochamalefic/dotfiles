-- ---------------------------------------------------------------------------
--  COMMON PLUGINS
-- ---------------------------------------------------------------------------

local g = vim.g
local fn = vim.fn
local uv = vim.uv
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local utils = require("utils")

local myDenops = require("plugins.plugin.config.denops")

return {
  {
    'Shougo/pum.vim',
    config = function()
      fn['pum#set_option']({
        max_width     = 100,
        --use_complete  = true,
        border        = 'rounded',
        padding       = true
      })

      local blend = 20

      api.nvim_set_option('pumblend', blend)

      local augroup_id = api.nvim_create_augroup('transparent-windows', { clear = true })
      api.nvim_create_autocmd('FileType', {
        group = augroup_id,
        pattern = '*',
        callback = function ()
          api.nvim_set_option('winblend', blend)
        end
      })
    end
  },
  {
    'kevinhwang91/promise-async'
  },
  {
    'vim-denops/denops.vim',
    build = function()
      myDenops.setup()
      myDenops.build()
    end,
    config = function()
      myDenops.setup()
      myDenops.configure()
    end,
  },
  {
    'nvim-tree/nvim-web-devicons'
  },
  {
    -- completion [{()}]
    lazy = true,
    'tpope/vim-surround',
    event = { 'BufEnter' }
  },
  {
    lazy = true,
    'osyo-manga/vim-precious',
    dependencies = { 'Shougo/context_filetype.vim' },
    event = { 'BufEnter' }
  },
  {
    lazy = true,
    'LeafCage/vimhelpgenerator',
--    ft = { 'vimscript', 'lua', 'typescript' }
  },
  {
    -- windows のクリップボード履歴の利用
    lazy = true,
    'Milly/windows-clipboard-history.vim',
    enabled = function () return vim.fn.has("win32") end
  },
  {
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
      vim.g.rengbang_default_pattern  = '\\(\\d\\+\\)'
      vim.g.rengbang_default_start    = 0
      vim.g.rengbang_default_step     = 1
      vim.g.rengbang_default_usefirst = 0
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
      vim.keymap.set('n', "*",  "<Plug>(asterisk-z*)")
      vim.keymap.set('n', "#",  "<Plug>(asterisk-z#)")
      vim.keymap.set('n', "g*", "<Plug>(asterisk-gz*)")
      vim.keymap.set('n', "g#", "<Plug>(asterisk-gz#)")
    end
  },
  {
    -- line diff / 行にgitの変更箇所を表示する
    'AndrewRadev/linediff.vim',
    event = { 'FileReadPost', 'InsertChange' }
  },
  {
    lazy = true,
    "nvim-lua/plenary.nvim",
    build = "npm install -g textlint textlint-rule-prh textlint-rule-preset-jtf-style textlint-rule-preset-ja-technical-writing textlint-rule-terminology textlint-rule-preset-ja-spacing",
  },
  -- trailing space / 行末の無意味なスペースを削除する
  {
    lazy = true,
    'lewis6991/spaceless.nvim',
    event = { 'FileReadPost', 'InsertLeave' },
    config = function()
      require'spaceless'.setup()
    end
  },
}

