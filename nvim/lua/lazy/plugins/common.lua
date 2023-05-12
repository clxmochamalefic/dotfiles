return {
  {
    'Shougo/pum.vim',
    init = function()
      vim.fn['pum#set_option']('max_width', 100)
      vim.fn['pum#set_option']('use_complete', true)
      vim.fn['pum#set_option']('border', 'rounded')

      local blend = 20

      vim.api.nvim_set_option('pumblend', blend)

      local augroup_id = vim.api.nvim_create_augroup('transparent-windows', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = augroup_id,
        pattern = '*',
        callback = function ()
          vim.api.nvim_set_option('winblend', blend)
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
    'vim-denops/denops.vim',
    init = function()
      vim.g.denops.deno = "deno"
      local function run_deno_server()
        vim.fn.execute("sh -c 'deno run -A --no-lock ./denops/@denops-private/cli.ts'", "silent")
        vim.g.denops_server_addr = '127.0.0.1:32123'
      end

      vim.fn.command("RunDenoServer", run_deno_server())
      vim.fn.command("Rds", "RunDenoServer")
    end
  },
  {
    'kyazdani42/nvim-web-devicons'
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown', 'pandoc.markdown', 'rmd', 'md' },
    lazy = true,
    init = function()
      if vim.fn.has('win32') then
        vim.fn.execute('pwsh -c "cd app && yarn install"')
      else
        vim.fn.execute('sh -c "cd app && yarn install"')
      end
    end
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
    ft = { 'vimscript', 'lua', 'typescript' }
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
      vim.g.asterisk.keeppos = 1
      vim.map.set("*",  "<Plug>(asterisk-z*)")
      vim.map.set("#",  "<Plug>(asterisk-z#)")
      vim.map.set("g*", "<Plug>(asterisk-gz*)")
      vim.map.set("g#", "<Plug>(asterisk-gz#)")
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

