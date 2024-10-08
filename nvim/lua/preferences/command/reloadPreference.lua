local M = {}

M.setup = function()
  --  init.vim reload
  local function reload_preference()
    if vim.fn.has("gui_running") then
      vim.fn["execute"]("source " .. M.ginitvim_filepath)
    end
    vim.fn["execute"]("source " .. M.initvim_filepath)
  end

  local function reload_all()
    reload_preference()
  end

  vim.api.nvim_create_user_command("ReloadPreference", reload_preference, {})
  vim.api.nvim_create_user_command("Rer", reload_preference, {})
  vim.api.nvim_create_user_command("ReloadAll", reload_all, {})
  vim.api.nvim_create_user_command("Rea", reload_all, {})
end

return M;
