-- colorscheme plugins
return {
  'cocopon/iceberg.vim',
  'jdkanani/vim-material-theme',
  'ciaranm/inkpot',
  'ryanoasis/vim-devicons',
  {
    'sonph/onehalf',
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/vim")
    end
  }
}

