return {
  {
'voldikss/vim-floaterm',
lazy = true,

  }
}
[[plugins]]
repo = 
on_cmd = 'Floaterm'
lua_add = '''
  vim.keymap.set("n", "<C-w>", "<Cmd>Floaterm<CR>", { silent = true })
'''
hook_source = '''
  execute "source " . expand(g:my_initvim_path . "/plugins/floaterm.lua")
'''
hook_post_source = '''
  command! Floaterm exec "FloatermToggle"
'''
