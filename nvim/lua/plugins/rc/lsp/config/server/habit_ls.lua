-- habit-language-server の設定

local ok_lspconfig, lspconfig = pcall(require, 'lspconfig')
if not ok_lspconfig then
  vim.notify('nvim-lspconfig が見つかりません', vim.log.levels.ERROR)
  return
end

local configs = require('lspconfig.configs')

-- habit-language-server をカスタムサーバーとして登録
if not configs.habit_language_server then
  configs.habit_language_server = {
    default_config = {
      -- cargo install --path . でインストールした場合は 'habit-language-server' のみで OK
      -- フルパスを指定する場合: vim.fn.expand('~/.cargo/bin/habit-language-server')
      cmd = { 'habit-language-server' },

      -- 対象ファイルタイプ（追加・削除して調整してください）
      filetypes = { 'text', 'markdown', 'gitcommit', 'rst' },

      -- ルートディレクトリが不要なサーバーなので常に cwd を使う
      root_dir = function(_)
        return vim.fn.getcwd()
      end,

      -- ファイル単体でも動作させる
      single_file_support = true,

      settings = {},
    },
    docs = {
      description = 'habit-language-server — 入力履歴ベースの補完 LSP',
    },
  }
end

-- on_attach: バッファにアタッチしたときに実行するキーマップ等
local function on_attach(_, bufnr)
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  -- 手動で補完を呼び出したい場合（例: <C-x><C-o> の代わりに）:
  -- vim.keymap.set('i', '<C-Space>', vim.lsp.buf.completion, opts)
end

-- nvim-cmp を使っている場合は capabilities を渡すと補完が快適になる
local capabilities = vim.lsp.protocol.make_client_capabilities()
--local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
--if ok_cmp then
--  capabilities = cmp_lsp.default_capabilities(capabilities)
--end

lspconfig.habit_language_server.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

