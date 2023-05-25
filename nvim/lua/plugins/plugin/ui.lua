return {
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('alpha').setup(require'alpha.themes.dashboard'.config)
    end
  },
  {
    'RRethy/vim-illuminate',
    lazy = true,
    event = { 'BufReadPost', 'FileReadPost' },
    config = function()
      require('illuminate').configure({
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          'lsp',
          'regex',
        },
        -- delay: delay in milliseconds
        delay = 100,
        -- filetype_overrides: filetype specific overrides.
        -- The keys are strings to represent the filetype while the values are tables that
        -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
        filetype_overrides = {},
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
          'dirvish',
          'fugitive',
        },
        -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
        filetypes_allowlist = {},
        -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
        -- See `:help mode()` for possible values
        modes_denylist = {},
        -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
        -- See `:help mode()` for possible values
        modes_allowlist = {},
        -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_denylist = {},
        -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_allowlist = {},
        -- under_cursor: whether or not to illuminate under the cursor
        under_cursor = true,
        -- large_file_cutoff: number of lines at which to use large_file_config
        -- The `under_cursor` option is disabled when this cutoff is hit
        large_file_cutoff = nil,
        -- large_file_config: config to use for large files (based on large_file_cutoff).
        -- Supports the same keys passed to .configure
        -- If nil, vim-illuminate will be disabled for large files.
        large_file_overrides = nil,
        -- min_count_to_highlight: minimum number of matches required to perform highlighting
        min_count_to_highlight = 1,
      })
    end
  },
  {
    'norcalli/nvim-colorizer.lua',
    lazy = true,
    event = { 'BufReadPost', 'FileReadPost' },
    config = function()
      require('colorizer').setup()
    end
  },
  {
    'petertriho/nvim-scrollbar',
    lazy = true,
    dependencies = {
      {
        'kevinhwang91/nvim-hlslens',
        lazy = true,
        dependencies = { 'kevinhwang91/nvim-ufo', },
        event = { 'BufReadPost', 'FileReadPost' },
        config = function()
          require('hlslens').setup()
          local kopts = {noremap = true, silent = true}

          vim.api.nvim_set_keymap('n', 'n',
          [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
          kopts)
          vim.api.nvim_set_keymap('n', 'N',
          [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
          kopts)
          vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
          vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
          vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
          vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

          vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)
        end
      },
      'gitsigns.nvim'
    },
    event = { 'FileReadPost', 'CursorHold', 'CursorHoldI' },
    config = function()
      require('gitsigns').setup()
      require("scrollbar.handlers.gitsigns").setup()
      require("scrollbar").setup({
        show                = true,
        show_in_active_only = false,
        set_highlights      = true,
        folds               = 1000,   -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
        max_lines           = false,  -- disables if no. of lines in buffer exceeds this
        hide_if_all_visible = false,  -- Hides everything if all lines are visible
        throttle_ms         = 100,
        handle = {
          text                = " ",
          color               = nil,
          color_nr            = nil, -- cterm
          highlight           = "CursorColumn",
          hide_if_all_visible = true, -- Hides handle if all lines are visible
        },
        marks = {
          Cursor = {
            text      = "•",
            priority  = 0,
            gui       = nil,
            color     = nil,
            cterm     = nil,
            color_nr  = nil, -- cterm
            highlight = "Normal",
          },
          Search = {
            text      = { "-", "=" },
            priority  = 1,
            gui       = nil,
            color     = nil,
            cterm     = nil,
            color_nr  = nil, -- cterm
            highlight = "Search",
          },
          Error = {
            text      = { "-", "=" },
            priority  = 2,
            gui       = nil,
            color     = nil,
            cterm     = nil,
            color_nr  = nil, -- cterm
            highlight = "DiagnosticVirtualTextError",
          },
          Warn = {
            text      = { "-", "=" },
            priority  = 3,
            gui       = nil,
            color     = nil,
            cterm     = nil,
            color_nr  = nil, -- cterm
            highlight = "DiagnosticVirtualTextWarn",
          },
          Info = {
            text      = { "-", "=" },
            priority  = 4,
            gui       = nil,
            color     = nil,
            cterm     = nil,
            color_nr  = nil, -- cterm
            highlight = "DiagnosticVirtualTextInfo",
          },
          Hint = {
            text      = { "-", "=" },
            priority  = 5,
            gui       = nil,
            color     = nil,
            cterm     = nil,
            color_nr  = nil, -- cterm
            highlight = "DiagnosticVirtualTextHint",
          },
          Misc = {
            text      = { "-", "=" },
            priority  = 6,
            gui       = nil,
            color     = nil,
            cterm     = nil,
            color_nr  = nil, -- cterm
            highlight = "Normal",
          },
          GitAdd = {
            text      = "┆",
            priority  = 7,
            gui       = nil,
            color     = nil,
            cterm     = nil,
            color_nr  = nil, -- cterm
            highlight = "GitSignsAdd",
          },
          GitChange = {
            text      = "┆",
            priority  = 7,
            gui       = nil,
            color     = nil,
            cterm     = nil,
            color_nr  = nil, -- cterm
            highlight = "GitSignsChange",
          },
          GitDelete = {
            text      = "▁",
            priority  = 7,
            gui       = nil,
            color     = nil,
            cterm     = nil,
            color_nr  = nil, -- cterm
            highlight = "GitSignsDelete",
          },
        },
        excluded_buftypes = {
          "terminal",
        },
        excluded_filetypes = {
          "prompt",
          "TelescopePrompt",
          "noice",
        },
        autocmd = {
          render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
          },
          clear = {
            "BufWinLeave",
            "TabLeave",
            "TermLeave",
            "WinLeave",
          },
        },
        handlers = {
          cursor      = true,
          diagnostic  = true,
          gitsigns    = false, -- Requires gitsigns
          handle      = true,
          search      = false, -- Requires hlslens
          ale         = false, -- Requires ALE
        },
      })
      require("scrollbar.handlers").register("my_marks", function(bufnr)
        return {
          { line = 0 },
          { line = 1, type = "Warn" , text = "x"},
          { line = 2, type = "Error" }
        }
      end)
    end
  },
  {
    'unblevable/quick-scope',
    lazy = true,
    event = { 'FileReadPost', 'InsertLeave' },
    config = function()
      -- Trigger a highlight in the appropriate direction when pressing these keys:
      vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
    end
  },
  {
    'yutkat/wb-only-current-line.nvim',
    lazy = true,
    event = { 'FileReadPost', 'InsertEnter' }
  },
  {
    'rcarriga/nvim-notify',
    lazy = true,
    event = { 'BufEnter' },
    init = function()
      vim.notify = require("notify")
--      vim.notify.setup({
--          background_colour = "#000000",
--      })
    end
  },
  {
    'kwkarlwang/bufresize.nvim',
    lazy = true,
    event = { 'FileReadPost', 'InsertEnter' },
    config = function()
      local bufresize = require("bufresize")
      bufresize.setup()
    end
  },
  {
    'Rasukarusan/nvim-popup-message',
    lazy = true,
    event = { 'VimEnter' },
    config = function()
      vim.api.nvim_create_user_command(
      'PopMess',
      function(opts)
        vim.fn["popup_message#open"]("execute('messages')")
      end, {})
    end
  },
}

