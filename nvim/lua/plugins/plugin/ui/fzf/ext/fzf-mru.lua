local myutils = require("utils")

return {
  {
    lazy = true,
    'pbogut/fzf-mru.vim'
    dependencies = {
      'junegunn/fzf',
    },
    cmd = {
      'Telescope fzf_mru',
    },
    config = function()
      require('telescope').load_extension('fzf_mru')
    end,
  },
}
