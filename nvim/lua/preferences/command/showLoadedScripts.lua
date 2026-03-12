local M = {}

M.setup = function()
  local function ls()
    vim.cmd([[enew|pu=execute('scriptnames')]])
  end
  vim.api.nvim_create_user_command("ShowLoadedScripts", ls, {})

  local function ac()
    vim.cmd([[enew|pu=execute('autocmd')]])
  end
  vim.api.nvim_create_user_command("ShowAutoCommands", ac, {})
end

return M
