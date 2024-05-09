local myutils = require("utils")

return {
  {
    lazy = true,
    'pbogut/fzf-mru.vim'
    event = "VeryLazy"
    dependencies = {
      'junegunn/fzf',
    },
    config = function()
      require('telescope').load_extension('fzf_mru')
    end,
  },
}
