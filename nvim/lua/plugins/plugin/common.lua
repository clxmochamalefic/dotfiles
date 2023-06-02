local g = vim.g
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

return {
  {
    lazy = true,
    'Shougo/pum.vim',
    config = function()
      fn['pum#set_option']({
        max_width     = 100,
        use_complete  = true,
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
    't9md/vim-choosewin',
    init = function()
      vim.keymap.set("n", "-", "<Plug>(choosewin)")
    end
  },
  {
    'kevinhwang91/promise-async'
  },
  {
    'vim-denops/denops.vim',
  },
  {
    'nvim-tree/nvim-web-devicons'
  },
  {
    'iamcco/markdown-preview.nvim',
    dependencies = {
      "zhaozg/vim-diagram",
      "aklt/plantuml-syntax",
    },
    lazy = true,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    cmd = { "MarkdownPreview" },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
--    ft = { 'markdown', 'pandoc.markdown', 'rmd', 'md' },
  },
  {
    -- completion [{()}]
    'tpope/vim-surround',
    lazy = true,
    event = { 'BufEnter' }
  },
  {
    'osyo-manga/vim-precious',
    lazy = true,
    dependencies = { 'Shougo/context_filetype.vim' },
    event = { 'BufEnter' }
  },
  {
    'LeafCage/vimhelpgenerator',
    lazy = true,
--    ft = { 'vimscript', 'lua', 'typescript' }
  },
  {
    'Milly/windows-clipboard-history.vim',
    lazy = true,
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
    'deris/vim-rengbang',
    lazy = true,
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
    'haya14busa/vim-asterisk',
    lazy = true,
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
    'AndrewRadev/linediff.vim',
    event = { 'FileReadPost', 'InsertChange' }
  },
  {
    'Pocco81/abbrev-man.nvim',
    lazy = true,
    event = { 'FileReadPost', 'InsertChange' },
    config = function()
      local abbrev_man = require("abbrev-man")
      abbrev_man.setup({
        load_natural_dictionaries_at_startup = true,
        load_programming_dictionaries_at_startup = true,
        natural_dictionaries = {
          ["nt_en"] = {}
        },
        programming_dictionaries = {
          ["pr_py"] = {}
        }
      })
    end
  },
}

