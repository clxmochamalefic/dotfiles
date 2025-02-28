--
-- 入力支援プラグイン等
--
local lsp = vim.lsp

return {
  {
    -- 自動タグ閉じ
    -- https://github.com/windwp/nvim-ts-autotag
    lazy = true,
    "windwp/nvim-ts-autotag",
    event = { "FileReadPost" },
    config = function()
      require("nvim-treesitter.configs").setup({
        autotag = {
          enable = true,
        },
      })

      lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = {
          spacing = 5,
          severity_limit = "Warning",
        },
        update_in_insert = true,
      })
    end,
  },
  {
    -- 自動括弧閉じ
    -- https://github.com/windwp/nvim-autopairs
    lazy = true,
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
    config = function()
      local npairs = require("nvim-autopairs")
      -- add option map_cr
      npairs.setup({ map_cr = true })
    end,
  },
  --{
  --  lazy = true,
  --  "tyru/caw.vim",
  --  event = "InsertEnter",
  --  opts = {}, -- this is equalent to setup({}) function
  --  config = function()
  --    local mopt = { noremap = true, silent = true }
  --    vim.keymap.set({ "n", "v" }, "<C-_>", "<Plug>(caw:i:toggle)", mopt)
  --    vim.keymap.set({ "i" }, "<C-_>", "<Cmd><Plug>(caw:i:toggle)<CR>", mopt)
  --  end,
  --},
}
