[[plugins]]
repo = 'MunifTanjim/nui.nvim'
on_source = ['fine-cmdline.nvim']

[[plugins]]
repo = 'VonHeikemen/fine-cmdline.nvim'
depends = ['nui.nvim']
on_event = ['VimEnter']
hook_post_source = '''
  execute "source " . g:my_initvim_path . "/plugins/nui.vim"
'''

