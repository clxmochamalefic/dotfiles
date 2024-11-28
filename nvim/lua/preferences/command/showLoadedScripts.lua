local M = {}

M.setup = function()
  local function f()
    vim.cmd([[enew|pu=execute('scriptnames')]])
  end
  vim.api.nvim_create_user_command("ShowLoadedScripts", f, {})
end

return M
