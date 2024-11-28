--local g = vim.g
--local fn = vim.fn
--local uv = vim.uv
--local api = vim.api
--local opt = vim.opt
--local keymap = vim.keymap
--
--local myWinPick = require("plugins.plugin.config.winpick")
--local utils = require("utils")
--
--local myDenops = require("plugins.plugin.config.denops")
--

--local skk = require("plugins.plugin.config.ime.skk")

return {
  --  {
  --    'keaising/im-select.nvim',
  --    config = function()
  --      require('im_select').setup {
  --      }
  --    end
  --  }
  {
    "vim-skk/skkeleton",
    dependencies = {
      "vim-denops/denops.vim",
      "delphinus/skkeleton_indicator.nvim",
      "ddc.vim",
    },
    condition = false,
    lazy = true,
    event = { "InsertEnter", "CursorHold" },
    --keys = {
    --  {
    --    "<C-j>",
    --    "<Plug>(skkeleton-toggle)",
    --    {
    --      mode = "i",
    --      desc = "[skk] toggle on insert mode",
    --    },
    --  },
    --  {
    --    "<C-j>",
    --    "<Plug>(skkeleton-toggle)",
    --    {
    --      mode = "c",
    --      desc = "[skk] toggle on ex mode",
    --    },
    --  },
    --},
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
    "delphinus/skkeleton_indicator.nvim",
    condition = false,
    lazy = true,
    config = function()
      require("skkeleton_indicator").setup()
    end,
  },
}
