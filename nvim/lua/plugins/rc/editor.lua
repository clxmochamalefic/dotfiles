
return {
  {
    lazy = true,
    'numToStr/Comment.nvim',
    event = { 'FileReadPost', 'VeryLazy', },
    opts = {
        -- add any options here
        ignore = '^$',
        -- 単行
        toggler = {
          -- <C-/> は設定として機能しないため、<C-_> を使用
          line = '<C-_>',
          --block = '<C-_>',
        },
        -- 複数行
        opleader = {
          -- <C-/> は設定として機能しないため、<C-_> を使用
          line = '<C-_>',
          --block = '<leader>b',
        },
    },
    config = function(_, opts)
      local c = require("Comment")
      c.setup(opts)

      vim.notify("preference comment.ft")
      local ft = require("Comment.ft")
      ft.set("sql", { "-- %s", "/* %s */" })
    end,
  }
}
