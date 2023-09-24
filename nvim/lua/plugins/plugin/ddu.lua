local utils = require("utils")

local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local km_opts = require("const.keymap")
--local lsplist = require("plugins.plugin.indevidual.lsplist")
local ddu = require("plugins.plugin.individual.ddu")

return {
  {
    lazy = true,
    "Shougo/ddu.vim",
    dependencies = {
      "vim-denops/denops.vim",

      "Shougo/ddu-ui-ff",
      "Shougo/ddu-ui-filer",

      "Shougo/ddu-source-action",
      "Shougo/ddu-source-buffer",
      "liquidz/ddu-source-custom-list",
      "4513ECHO/ddu-source-emoji",
      "Shougo/ddu-source-file",
      "Shougo/ddu-source-file_old",
      "Shougo/ddu-source-file_rec",
      "kuuote/ddu-source-mr",

      "gamoutatsumi/ddu-source-nvim-lsp",
      "uga-rosa/ddu-source-lsp",

      "4513ECHO/ddu-source-source",

      "Shougo/ddu-filter-matcher_substring",

      "Shougo/ddu-kind-file",
      "Shougo/ddu-kind-word",

      "Shougo/ddu-column-filename",
      "ryota2357/ddu-column-icon_filename",
      "tamago3keran/ddu-column-devicon_filename",

      "matsui54/ddu-vim-ui-select",

      "Milly/windows-clipboard-history.vim",
    },
    config = function()
      ddu.setup()

      api.nvim_create_user_command("DduFiler",      ddu.ui.filer.util.show,  {})
      api.nvim_create_user_command("DduFF",         ddu.ui.ff.util.show,     {})

      --fn["timer_start"](3, function()
      --  fn["ddu#start"]({ ui = "" })
      --end)
    end,
    cmd = { "DduFiler", "DduFF", "DduLspActions" },
    keys = {
      { "z", "<cmd>DduFiler<CR>", mode = "n" },
      { "Z", "<cmd>DduFF<CR>", mode = "n" },
      { "<F2>", "<cmd>DduLspActions<CR>", mode = "n" },
    },
  },
  {
    lazy = true,
    "kuuote/ddu-source-mr",
    dependencies = { "lambdalisue/mr.vim" },
  },
  {
    lazy = true,
    "uga-rosa/ddu-source-lsp",
    dependencies = { "neovim/nvim-lspconfig" },
  },
}
