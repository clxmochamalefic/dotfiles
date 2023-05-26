-- colorscheme plugins

local g = vim.g
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

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

