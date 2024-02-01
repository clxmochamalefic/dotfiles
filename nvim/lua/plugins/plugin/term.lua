-- ---------------------------------------------------------------------------
-- TERMINAl PLUGINS
-- ---------------------------------------------------------------------------

local g = vim.g
local o = vim.o
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local colour = require("const.colour")

return {
  {
    lazy = true,
    "voldikss/vim-floaterm",
    cmd = "Floaterm",
    keys = {
      -- { "_", "<cmd>FloatermToggle<CR>", mode = "n" },
    },
    config = function()
      g.floaterm_autoclose = 1
      g.floaterm_height = 0.3
      g.floaterm_width = 0.8
      g.floaterm_position = "bottom"
      g.floaterm_title = "floaterm $1/$2"

      local augroup_id = api.nvim_create_augroup("floaterm", {})
      api.nvim_create_autocmd("FileType", {
        group = augroup_id,
        pattern = "floaterm",
        callback = function()
          keymap.set("n", "q", "<Cmd>FloatermToggle<CR>", { noremap = true, silent = true, buffer = true })
          keymap.set("n", "<F8>", "<Cmd>FloatermNew<CR>", { noremap = true, silent = true, buffer = true })
          keymap.set("n", "<F6>", "<Cmd>FloatermPrev<CR>", { noremap = true, silent = true, buffer = true })
          keymap.set("n", "<F7>", "<Cmd>FloatermNext<CR>", { noremap = true, silent = true, buffer = true })
        end,
      })

      api.nvim_create_user_command("Floaterm", "<Cmd>FloatermToggle<CR>", {})
    end,
  },
  {
    lazy = true,
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    keys = {
      { "_", "<cmd>ToggleTerm<CR>", mode = "n" },
    },
    opts = function() end,
    config = function()
      require("toggleterm").setup({
        -- size can be a number or function which is passed the current terminal
        size = 10,
        --size = function(term)
        --  if term.direction == "horizontal" then
        --    return 15
        --  elseif term.direction == "vertical" then
        --    return vim.o.columns * 0.4
        --  end
        --end,
        --open_mapping = [[<c-\>]],
        --on_create = fun(t: Terminal), -- function to run when the terminal is first created
        --on_open = fun(t: Terminal), -- function to run when the terminal opens
        --on_close = fun(t: Terminal), -- function to run when the terminal closes
        --on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
        --on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
        --on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
        --hide_numbers = true, -- hide the number column in toggleterm buffers
        hide_numbers = true, -- hide the number column in toggleterm buffers
        --shade_filetypes = {},
        autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
        highlights = {
          -- highlights which map to a highlight group name and a table of it's values
          -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
          Normal = {
            guibg = colour.azure.g.secondary.bg,
            guifg = colour.azure.g.secondary.fg,
          },
          --NormalFloat = {
          --  link = 'Normal'
          --},
          --FloatBorder = {
          --  guifg = "<VALUE-HERE>",
          --  guibg = "<VALUE-HERE>",
          --},
        },
        shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
        --shading_factor = '<number>', -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        persist_size = true,
        persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
        direction = "horizontal", -- vertical' | 'horizontal' | 'tab' | 'float',
        close_on_exit = true, -- close the terminal window when the process exits
        -- Change the default shell. Can be a string or a function returning a string
        shell = o.shell,
        --auto_scroll = true, -- automatically scroll to the bottom on terminal output
        auto_scroll = false, -- automatically scroll to the bottom on terminal output
        -- This field is only relevant if direction is set to 'float'
        --float_opts = {
        --  -- The border key is *almost* the same as 'nvim_open_win'
        --  -- see :h nvim_open_win for details on borders however
        --  -- the 'curved' border is a custom border type
        --  -- not natively supported but implemented in this plugin.
        --  border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        --  -- like `size`, width and height can be a number or function which is passed the current terminal
        --  width = <value>,
        --  height = <value>,
        --  winblend = 3,
        --  zindex = <value>,
        --},
        winbar = {
          enabled = false,
          name_formatter = function(term) --  term: Terminal
            return term.name
          end,
        },
      })
    end,
  },
}
