local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

return {
  {
    lazy = true,
    'voldikss/vim-floaterm',
    cmd = 'Floaterm',
    keys = {
      -- { "_", "<cmd>FloatermToggle<CR>", mode = "n" },
    },
    config = function()
      g.floaterm_autoclose  = 1
      g.floaterm_height     = 0.3
      g.floaterm_width      = 0.8
      g.floaterm_position   = "bottom"
      g.floaterm_title      = 'floaterm $1/$2'

      local augroup_id = api.nvim_create_augroup('floaterm', {})
      api.nvim_create_autocmd('FileType', {
        group = augroup_id,
        pattern = 'floaterm',
        callback = function ()
          keymap.set('n', 'q',    '<Cmd>FloatermToggle<CR>',  { noremap = true, silent = true, buffer = true })
          keymap.set('n', '<F8>', '<Cmd>FloatermNew<CR>',     { noremap = true, silent = true, buffer = true })
          keymap.set('n', '<F6>', '<Cmd>FloatermPrev<CR>',    { noremap = true, silent = true, buffer = true })
          keymap.set('n', '<F7>', '<Cmd>FloatermNext<CR>',    { noremap = true, silent = true, buffer = true })
        end
      })

      api.nvim_create_user_command("Floaterm",  '<Cmd>FloatermToggle<CR>', {})
    end
  },
  {
    lazy = true,
    'akinsho/toggleterm.nvim',
    cmd = 'ToggleTerm',
    keys = {
      { "_", "<cmd>ToggleTerm<CR>", mode = "n" },
    },
    opts = function()
    end,
    config = function()
      require("toggleterm").setup()
    end
  }
}

