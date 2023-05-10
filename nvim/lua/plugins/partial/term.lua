return {
  {
    'voldikss/vim-floaterm',
    lazy = true,
    cmd = 'Floaterm',
    config = function()
      vim.fn.command("Floaterm", vim.fn.execute("FloatermToggle"))
      vim.keymap.set("n", "<C-w>", "<Cmd>Floaterm<CR>", { silent = true })

      vim.g.floaterm_autoclose  = 1
      vim.g.floaterm_height     = 0.3
      vim.g.floaterm_width      = 0.8
      vim.g.floaterm_position   = "bottom"
      vim.g.floaterm_title      = 'floaterm $1/$2'

      local augroup_id = vim.api.nvim_create_augroup('floaterm', {})
      vim.api.nvim_create_autocmd('FileType', {
        group = augroup_id,
        pattern = 'floaterm',
        callback = function ()
          vim.keymap.set('n', 'q', '<Cmd>FloatermToggle<CR>', { noremap = true, silent = true, buffer = true })
        end
      })
    end

  }
}

