local M = {}

local wndutil = require('utils.sub.window')

function M.setup()
  local mnl_stat, mason_null_ls = pcall(require, "mason-null-ls")
  if not mnl_stat then
    return
  end
  local status, null_ls = pcall(require, "null-ls")
  if not status then
    return
  end
  local nlu_stat, null_ls_utils = pcall(require, "null-ls.utils")
  if not nlu_stat then
    return
  end

  local formatting = null_ls.builtins.formatting -- to setup formatters
  local diagnostics = null_ls.builtins.diagnostics -- to setup linters
  local completion = null_ls.builtins.completion -- to setup linters

  local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
  local event = "BufWritePre" -- BufWritePre or "BufWritePost"
  local hasAsyncable = event == "BufWritePre"

  null_ls.setup({
    root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
    diagnostics_format = "#{m} (#{s}: #{c})",
    on_attach = function(client, bufnr)
      -- lsp format
      if client.supports_method("textDocument/formatting") then
        -- format on save
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
        vim.api.nvim_create_autocmd(event, {
          buffer = bufnr,
          group = group,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, async = hasAsyncable })
          end,
          desc = "[lsp] format on save",
        })
        --callback = function()
        --  vim.lsp.buf.format({
        --    filter = function(client)
        --      --  only use null-ls for formatting instead of lsp server
        --      return client.name == "null-ls"
        --    end,
        --    bufnr = bufnr,
        --    async = hasAsyncable,
        --})
      end

      if client.supports_method("textDocument/rangeFormatting") then
        vim.keymap.set("x", "<Leader>F", function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end, { buffer = bufnr, desc = "[lsp] format" })
      end
    end,
    sources = {
      diagnostics.eslint_d.with({
        diagnostics_format = "[eslint] #{m}\n(#{c})",
        condition = function(utils)
          -- only enable if root has .eslintrc.js or .eslintrc.cjs
          return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" })
        end,
      }),
      diagnostics.prettier,
      formatting.prettier,
      completion.tags,
      completion.spell,
      completion.vsnip,
    },
    debug = false,
  })

  local lspconfig = require("lspconfig")
  lspconfig["null-ls"].setup({})
end

return M

