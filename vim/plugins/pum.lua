vim.call('pum#set_option', 'max_width', 100)
vim.call('pum#set_option', 'use_complete', true)
vim.call('pum#set_option', 'border', 'rounded')

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

