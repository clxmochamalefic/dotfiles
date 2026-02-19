local M = {}

M.setup = function()
  vim.api.nvim_create_user_command("ShowLspSymbol", vim.lsp.buf.document_symbol, {})
end

return M

