return {
  {
    lazy = true,
    'mattn/vim-gist',
    event = { "VeryLazy" },
    cmd = { "Gist" },
    dependencies = {
      'mattn/webapi-vim',
    },
    opts = {
    },
    config = function(_, opts)
      vim.g.gist_detect_filetype = 1
      vim.g.gist_open_browser_after_post = 1
    end,
  },
}

