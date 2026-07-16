---@diagnostic disable: undefined-global
-- ---------------------------------------------------------------------------
-- TREESITTER CONFIGS
-- ---------------------------------------------------------------------------

-- NOTE: `main` ブランチ (書き直し版) を使用。旧 `master` とは設定 API が別物
--       (`ensure_installed` 等は無く、 `install()` + `vim.treesitter.start()` で構成する)
local parsers = {
  "lua",
  "vim",
  "vimdoc",
  "bash",

  -- blade 内のインジェクション解決に html / javascript / php_only が必要
  -- (blade の injections.scm は html のクエリを継承している)
  "blade",
  "html",
  "css",
  "javascript",
  "typescript",
  "php",
  "php_only",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    -- パーサーはランタイムに必要なので遅延ロードしない (公式 README 推奨)
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
        callback = function()
          -- パーサー未導入の filetype は pcall でエラーを無視
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
