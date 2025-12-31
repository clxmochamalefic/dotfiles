local M = {}

M.setup = function(my_colorscheme)
  local augroupid = vim.api.nvim_create_augroup("MyhlNotify", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = augroupid,
    callback = function()
      table.insert(my_colorscheme, get_hl_table("NotifyBorder", "none"))
      table.insert(my_colorscheme, get_hl_table("NotifyTitle", "none"))
      table.insert(my_colorscheme, get_hl_table("NotifyBody", "none"))
      table.insert(my_colorscheme, get_hl_table("NotifyIcon", "none"))
    end,
  })
end

return M
