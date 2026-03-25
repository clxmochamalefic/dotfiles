local skk = require("plugins.rc.config.ime.skk")

local is_all_enabled = false

return {
  {
    condition = is_all_enabled,
    'keaising/im-select.nvim',
    config = true
  },
  {
    lazy = true,
    condition = is_all_enabled,
    "vim-skk/skkeleton",
    dependencies = {
      "vim-denops/denops.vim",
      "delphinus/skkeleton_indicator.nvim",
      "ddc.vim",
    },
    event = { "InsertEnter", "CursorHold" },
    keys = {
      {
        "<C-j>",
        "<Plug>(skkeleton-toggle)",
        {
          mode = "i",
          desc = "[skk] toggle on insert mode",
        },
      },
      {
        "<C-j>",
        "<Plug>(skkeleton-toggle)",
        {
          mode = "c",
          desc = "[skk] toggle on ex mode",
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'skkeleton-initialize-pre',
        callback = function()
          vim.fn['skkeleton#config']({
            globalDictionaries = {
              vim.fn.expand('~/.config/skk/SKK-JISYO.L'),
            },
            eggLikeNewline = true,
            keepState = true
          })
        end,
        group = vim.api.nvim_create_augroup('skkelectonInitPre', { clear = true }),
      })
    end,
    config = function()
      -- skk how to use
      -- winget install
      -- download below, extract, and create symblink to shell:startup
      -- https://github.com/nathancorvussolis/crvskkserv/releases/tag/2.5.6
      --skk.setup()
      vim.keymap.set("i", "<C-j>", '<Plug>(skkeleton-toggle)', { noremap = true, buffer = bufnr, silent = true, desc = "[skk] toggle on insert mode" })
      vim.keymap.set("c", "<C-j>", '<Plug>(skkeleton-toggle)', { noremap = true, buffer = bufnr, silent = true, desc = "[skk] toggle on ex mode" })
      --vim.keymap.set("t", "<C-J>", '<Plug>(skkeleton-toggle)', { noremap = true, buffer = bufnr, desc = "[skk] toggle on terminal mode" })
    end,
  },
  {
    condition = is_all_enabled,
    "delphinus/skkeleton_indicator.nvim",
    lazy = true,
    config = function()
      require("skkeleton_indicator").setup()
    end,
  },
}
