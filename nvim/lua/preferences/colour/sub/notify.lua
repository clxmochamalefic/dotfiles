local M = {}

M.setup = function(my_colorscheme, theme)
  local augroupid = vim.api.nvim_create_augroup("MyhlNotify", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = augroupid,
    callback = function()
      --table.insert(my_colorscheme, get_hl_table("NotifyBorder", theme.transparent))
      --table.insert(my_colorscheme, get_hl_table("NotifyTitle", theme.transparent))
      --table.insert(my_colorscheme, get_hl_table("NotifyBody", theme.transparent))
      --table.insert(my_colorscheme, get_hl_table("NotifyIcon", theme.transparent))
    end,
  })
end

return M
