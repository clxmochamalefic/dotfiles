local M = {}

function M.setup()
  local status, null_ls = pcall(require, "null-ls")
  if (not status) then return end

  local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
  local event = "BufWritePost" -- BufWritePre or "BufWritePost"
  local hasAsyncable = event == "BufWritePost"

  null_ls.setup({
    diagnostics_format = "#{m} (#{s}: #{c})",
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.keymap.set("n", "<Leader>F", function()
          vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = "[lsp] format" })

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
      end

      if client.supports_method("textDocument/rangeFormatting") then
        vim.keymap.set("x", "<Leader>F", function()
          vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = "[lsp] format" })
      end
    end,
    sources = {
      null_ls.builtins.diagnostics.eslint_d.with({
        diagnostics_format = '[eslint] #{m}\n(#{c})'
      }),
      null_ls.builtins.diagnostics.prettier,
      null_ls.builtins.completion.tags,
      null_ls.builtins.completion.spell,
      null_ls.builtins.completion.vsnip,
    },
    debug = false
  })

  local lspconfig = require "lspconfig"
  lspconfig["null-ls"].setup({})
end

return M
