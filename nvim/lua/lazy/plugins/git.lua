[[plugins]]
repo = 'TimUntersberger/neogit'
depends = ['diffview.nvim', 'gitsigns.nvim']
on_event = ['BufWrite', 'FileReadPost']
hook_source = '''
  execute "source " . g:my_initvim_path . "/plugins/git.lua"
'''

[[plugins]]
repo = 'sindrets/diffview.nvim'
depends = ['plenary.nvim']

[[plugins]]
repo = 'lewis6991/gitsigns.nvim'
on_event = ['BufEnter',]
#depends = ['vim-fugitive', 'git.nvim']


#[[plugins]]
#repo = 'tpope/vim-fugitive'
#
#[[plugins]]
#repo = 'dinhhuy258/git.nvim'
