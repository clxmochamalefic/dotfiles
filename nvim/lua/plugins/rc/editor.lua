
return {
  {
    -- matchit の完全代替。treesitter インジェクションを認識するため、
    -- blade ファイルの <script> 内 JavaScript の {} ジャンプも正しく動作する。
    "andymass/vim-matchup",
    lazy = false,
    init = function()
      -- matchit が先にロードされないよう事前に無効化
      vim.g.loaded_matchit = 1
      -- カーソル位置の対応括弧をポップアップで表示
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
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
