local utils = require("utils")

local km_opts = require("const.keymap")
local myddu = require("plugins.rc.ui.config.ddu")
--local lsplist = require("plugins.rc.indevidual.lsplist")

local willUse = true;

return {
  {
    lazy = true,
    cond = willUse,
    "Shougo/ddu.vim",
    tag = "v10.0.0",
    dependencies = {
      "vim-denops/denops.vim",
      {
        "Shougo/ddu-ui-ff",
        tag = "v2.0.0",
      },
      {
        "Shougo/ddu-ui-filer",
        tag = "v2.0.0",
      },

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
    --    keys = {
    --      { "z", "<cmd>DduFiler<CR>", mode = "n" },
    --      { "Z", "<cmd>DduFF<CR>", mode = "n" },
    --      { "<F2>", "<cmd>DduLspActions<CR>", mode = "n" },
    --    },
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
