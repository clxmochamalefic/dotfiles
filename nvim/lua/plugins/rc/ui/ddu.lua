local utils = require("utils")

local km_opts = require("const.keymap")
local myddu = require("plugins.rc.ui.config.ddu")
--local lsplist = require("plugins.rc.indevidual.lsplist")

local willUse = true;

local M = {
  dependDenops = {
    "vim-denops/denops.vim",
  },
  dependUi = {
    {
      "Shougo/ddu-ui-ff",
      tag = "v2.0.0",
    },
    {
      "Shougo/ddu-ui-filer",
      tag = "v2.0.0",
    },
  },
  dependSrc = {
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
  },
  dependFilter = {
    "Shougo/ddu-filter-matcher_substring",
  },
  dependKind = {
    "Shougo/ddu-kind-file",
    "Shougo/ddu-kind-word",
  },
  dependColumn = {
    "Shougo/ddu-column-filename",
    "ryota2357/ddu-column-icon_filename",
    "tamago3keran/ddu-column-devicon_filename",
    "kamecha/ddu-column-file_buf_modified",
  },
  dependOther = {
    "matsui54/ddu-vim-ui-select",
    "Milly/windows-clipboard-history.vim",
    "kamecha/ddu-filter-converter_file_git_status",
  },
}

local depends = {}

for _, group in pairs(M) do
  for _, v in pairs(group) do
    table.insert(depends, v)
  end
end

return {
  {
    lazy = true,
    cond = willUse,
    "Shougo/ddu.vim",
    tag = "v10.3.0",
    dependencies = depends,
    config = function()
      myddu.setup()

      vim.api.nvim_create_user_command("DduFiler", myddu.ui.filer.util.show, {})
      vim.api.nvim_create_user_command("DduFF", myddu.ui.ff.util.show, {})

      --vim.fn["timer_start"](3, function()
      --  vim.fn["ddu#start"]({ ui = "" })
      --end)
    end,
    cmd = {
      "DduFiler",
      "DduFF",
      "DduLspActions",
    },
    keys = {
      --{ "g<Space>", "<cmd>DduFiler<CR>", mode = "n" },
      { "Z", "<cmd>DduFiler<CR>", mode = "n" },
      --{ "Z",        "<cmd>DduFF<CR>",    mode = "n" },
      --{ "<F2>", "<cmd>DduLspActions<CR>", mode = "n" },
    },
  },
  {
    "kuuote/ddu-source-mr",
    lazy = true,
    dependencies = { "lambdalisue/mr.vim" },
  },
  {
    "uga-rosa/ddu-source-lsp",
    lazy = true,
    dependencies = { "neovim/nvim-lspconfig" },
  },
}
