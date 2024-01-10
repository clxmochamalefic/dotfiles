
return {
  {
    lazy = true,
    'uga-rosa/translate.nvim',
    event = { 'BufEnter' },
    config = function()
      require("translate").setup({})
    end,
  },
}
